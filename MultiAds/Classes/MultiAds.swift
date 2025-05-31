//
//  MultiAds.swift
//  Pods
//
//  Created by Khusnud Zehra on 31/05/25.
//

import Foundation
import SwiftyJSON
import SwiftUI
import StoreKit
import SwiftUI

@available(iOS 13.0, *)
public class MultiAdsManager {
    
    
    static  public let shared: MultiAdsManager = MultiAdsManager()
    @ObservedObject public var commonState:CommonChangables = CommonChangables.shared
    public init() {
    }

    public func postSetup(data: JSON,onSdkInitialized: @escaping () -> Void)  {
        ServerConfig.sharedInstance.configJson = data

        // Parse Screen Data
        let screenDataString = data["versions"][data["activeLevel"].stringValue].stringValue
        if let jsonDict = JsonMethods().convertToDictionary(jsonString: screenDataString) {
            ServerConfig.sharedInstance.screenConfig = JsonMethods().parseScreenData(screenData: jsonDict)
        } else {
            print("⚠️ Error Parsing Screen Data ⚠️")
            print("🐞 Trace From Data [Start]")
            print(screenDataString)
            print("🐞 Trace From Data [End]")
        }

        // Parse AdNetwork Ids
        let adNetworkIds = data["versions"]["adNetworkIds"].stringValue
        if let jsonDict = JsonMethods().convertToDictionary(jsonString: adNetworkIds) {
            ServerConfig.sharedInstance.adNetworkIds = JsonMethods().parseAdNetworkIds(adNetworkIds: jsonDict)
        } else {
            print("⚠️ Error Parsing AdNetworkIds ⚠️")
            print("🐞 Trace From Data [Start]")
            print(adNetworkIds)
            print("🐞 Trace From Data [End]")
        }

        // Parse Global Status
        let globalStatus = data["versions"]["global_ad_status"].intValue
        ServerConfig.sharedInstance.globalAdStatus = globalStatus == 0

        // Parse Init AdNetworks
        let initAdNetworks = data["versions"]["init_ad_network"].stringValue
        if let jsonDict = JsonMethods().convertToArray(jsonString: initAdNetworks) {
            ServerConfig.sharedInstance.initAdNetworks = jsonDict
        } else {
            print("⚠️ Error Parsing InitAdNetwork ⚠️")
            print("🐞 Trace From Data [Start]")
            print(initAdNetworks)
            print("🐞 Trace From Data [End]")
        }

        let onesignalKey = data["onesignal_key"].stringValue
        ServerConfig.sharedInstance.onesignalApiKey = onesignalKey

        // Parse Extra Config
        let extraConfigs = data["versions"]["extra_config"].stringValue
        if let jsonDict = JsonMethods().convertToArrayAny(jsonString: extraConfigs) {
            ServerConfig.sharedInstance.extraConfig = jsonDict as? [String: Any]

        } else {
            print("⚠️ Error Parsing ExtraConfig Array⚠️")
            print("🐞 Trace From Data [Start]")
            print(extraConfigs)
            print("🐞 Trace From Data [End]")
        }
        
        let updateDialogConfig = data["versions"]["update_dialog_config"].stringValue
        if let jsonDict = JsonMethods().convertToDictionary(jsonString: updateDialogConfig) {
            ServerConfig.sharedInstance.updateDialogConfig = jsonDict
        } else {
            print("⚠️ Error Parsing Update Diload Config ⚠️")
            print("🐞 Trace From Data [Start]")
            print(updateDialogConfig)
            print("🐞 Trace From Data [End]")
        }
        setupAdNetworks(onSdkInitialized: onSdkInitialized)
        
       
    }
    
    
    @available(iOS 14.0, *)
    public func inAppReviewCaller() {
        var count = UserDefaults.standard.integer(forKey: "appStartUpsCountKey")
              count += 1
              UserDefaults.standard.set(count, forKey: "appStartUpsCountKey")
              
              let infoDictionaryKey = kCFBundleVersionKey as String
              guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
                  else { fatalError("Expected to find a bundle version in the info dictionary") }

              let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: "lastVersionPromptedForReviewKey")
              
              if count >= 4 && currentVersion != lastVersionPromptedForReview {
                  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                      if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                          SKStoreReviewController.requestReview(in: scene)
                          UserDefaults.standard.set(currentVersion, forKey: "lastVersionPromptedForReviewKey")
                      }
                  }
              }
    }
    
   
   
    @available(iOS 13.0.0, *)
    public func setupAdNetworks(onSdkInitialized: @escaping () -> Void)  {
        if(ServerConfig.sharedInstance.loadAdNetwork == nil){
            return
        }
        let loadedNetworks : [NetworkType: NetworkInterface] =  ServerConfig.sharedInstance.loadAdNetwork!
        
        for (type, networkInterface) in loadedNetworks {
        
          let typeName = type.stringName
            if ServerConfig.sharedInstance.initAdNetworks.contains(typeName){
                let res =  networkInterface.initNetwork(onSdkInitialized: onSdkInitialized)
                print("[⚠️] Initialized \(typeName) : \(res)")
            }
         
        }
    }

    @MainActor public func setUp(registerAppParameters: RegisterAppParameters,onSdkInitialized: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Setting Loaded AdNetwork
            ServerConfig.sharedInstance.loadAdNetwork = registerAppParameters.requiredAdNetworks
            let identifier: UUID? = AppTrans().getTrackingIdentifierWithRequest()
            
            ApiReposiotry().deviceRegister(adId: identifier?.uuidString ?? "", registerAppParameters: RegisterAppParameters(
                apiKey: registerAppParameters.apiKey,
                onUpdateLaunch: registerAppParameters.onUpdateLaunch,
                onError: { Error in
                   print("Error \(Error)")
                  registerAppParameters.onError(Error.description)
               },
               onComplete: { _ in
                print("On Setup Complete")
                ApiReposiotry().fetchConfig(apiKey: registerAppParameters.apiKey.iosKey ?? "nil", appVersion: registerAppParameters.appVersion) { data in
                    if data != nil {
                        self.postSetup(data: data!,onSdkInitialized: onSdkInitialized)
                        // Check For Update
                        print("On Config Complete")
                        registerAppParameters.onComplete(ServerConfig.sharedInstance.configJson ?? JSON({}))
                    } else {
                        print("INValid Config Else")
                        registerAppParameters.onError("Invalid Config")
                    }
                } onError: { ErrorConfig in
                    print("Error Config \(ErrorConfig)")
                    registerAppParameters.onError(ErrorConfig.description)
                }
            },
            requiredAdNetworks: registerAppParameters.requiredAdNetworks
            )
          )
        }
    }
    
    
    
    
    
    
    public func showAds(from:String,adCallback:AdModuleWithCallBacks) {
        /*
          This Function Call Screen Based Ads
         */
        AdEngine.shared.loadScreenBasedAds(from: from,adCallback: adCallback)
    }
    
    public func showNativeAd(from:String) -> AnyView{
        /*
          This Function Call Screen Based Ads
         */
       return AdEngine.shared.loadShowNative(from: from)
    }
}


@available(iOS 13.0, *)
public extension View {
    func setup(registerAppParameters: RegisterAppParameters,onSdkInitialized: @escaping () -> Void){
        MultiAdsManager().setUp(registerAppParameters: registerAppParameters,onSdkInitialized: onSdkInitialized)
    }
}

@available(iOS 13.0, *)
public var rootController: UIViewController? {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        // Fallback for older iOS versions
        return UIApplication.shared.windows.first?.rootViewController
    }
    
    var root = window.rootViewController
    while let presenter = root?.presentedViewController {
        root = presenter
    }
    return root
}





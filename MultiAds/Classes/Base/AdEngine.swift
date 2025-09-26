//
//  MultiAds.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 30/01/25.
//

import SwiftUI

@available(iOS 14.0, *)
public class AdEngine {
    static var shared: AdEngine = AdEngine()
    
    @State var failedCounter: Int = 0

    let commonValue: CommonChangables = CommonChangables.shared
    
    
    public func loadFailed(from: String = "default", adCallback: AdModuleWithCallBacks,number:String) {
        print("✅ Config [loadFailed]")
        loadScreenBasedAds(from: from, adCallback: adCallback,number: number)
    }
    
    
  

    public func loadFromNumber(config: AdConfigDataModel, number: String, adCallback: AdModuleWithCallBacks) {
        print("⚠️ [loadFromNumber] : \(number)")
        switch number {
        case "1.0":
            print("⚠️ [loadFromNumber] Google Inter")
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.google] != nil
            if keyExists {
                print("⚠️ [loadFromNumber] Google Inter Key Exist")
                ServerConfig.sharedInstance.loadAdNetwork![.google]?.loadAndShowInterAd(adModuleCallBacks: adCallback)

                return
            }
            print("⚠️ [loadFromNumber] Google Inter Default Callback")

            adCallback.onCloseEvent?()
            break
        case "1.1":
            print("⚠️ [loadFromNumber] Google Reward")

            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.google] != nil
            if keyExists {
                print("⚠️ [loadFromNumber] Google Reward Key Exist")

                ServerConfig.sharedInstance.loadAdNetwork![.google]?.loadAndShowRewardAd(adModuleCallBacks: adCallback)
                return
            }
            print("⚠️ [loadFromNumber] Google Reward Default Callback")

            adCallback.onCloseEvent?()
            break
        case "1.2":
            print("⚠️ [loadFromNumber] Google Reward Inter")
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.google] != nil
            if keyExists {
                print("⚠️ [loadFromNumber] Google Reward Inter Key Exist")
                ServerConfig.sharedInstance.loadAdNetwork![.google]?.loadAndShowRewardInter(adModuleCallBacks: adCallback)
                return
            }
            print("⚠️ [loadFromNumber] Google Reward Inter Default Callback")

            adCallback.onCloseEvent?()
            break
        case "2.0":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.unity] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.unity]?.loadAndShowInterAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
        case "2.1":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.unity] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.unity]?.loadAndShowRewardAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
        case "2.2":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.unity] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.unity]?.loadAndShowRewardAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
        case "3.0":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.ironSource] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.ironSource]?.loadAndShowInterAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
        case "3.1":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.ironSource] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.ironSource]?.loadAndShowRewardAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
        case "3.2":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.ironSource] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.ironSource]?.loadAndShowRewardAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
        case "4.0":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.appLovin] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.appLovin]?.loadAndShowInterAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
        case "4.1":
            let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.appLovin] != nil
            if keyExists {
                ServerConfig.sharedInstance.loadAdNetwork![.appLovin]?.loadAndShowRewardAd(adModuleCallBacks: adCallback)
                return
            }
            adCallback.onCloseEvent?()
            break
    
        default:
            adCallback.onCloseEvent?()
            break
        }
    }

    public func loadScreenBasedAds(from: String = "default", adCallback: AdModuleWithCallBacks,number:String = "-1") {
        var localConfig: AdConfigDataModel? = ServerConfig.sharedInstance.screenConfig?[from]
        print("✅ Config [loadScreenBasedAds] Tap \(String(describing: localConfig?.tap))")
        print("✅ Config [loadScreenBasedAds]  \(String(describing: localConfig))")
        print("✅ Config [loadScreenBasedAds] From :  \(from)")
        print("✅ Config [loadScreenBasedAds] Failed COunter :  \(failedCounter)")
        
        if failedCounter > 3 {
            adCallback.onCloseEvent?()
            print("✅ Force End Failed Count Acced")
            return
        }
        
        
        
        if localConfig == nil {
            localConfig = ServerConfig.sharedInstance.screenConfig?["default"]
            print("✅ Local Config [loadScreenBasedAds]  \(String(describing: localConfig))")
        }

        
        
        
        
        if ServerConfig.sharedInstance.globalAdStatus {
            if localConfig!.showAds {
                
                
                MultiAdsManager.shared.commonState.adLoader = true
               
                
                print("✅ Local Config [loadScreenBasedAds]  Local true")
                var i = 0

                let callback = AdModuleWithCallBacks(
                    onCloseEvent: {
                        print("On Ad Close Event Fired 🔥")
                        self.failedCounter = 0
                        MultiAdsManager.shared.commonState.adLoader = false
                        adCallback.onCloseEvent?()
                    },
                    onFailed: {
                        let index : String? = localConfig!.failed?[localConfig!.tap![i].description]
                        if(index == nil){
                            print("nil Index Callback 🔥")
                            adCallback.onCloseEvent?()
                            return
                        }
                        print("On Fail Hit Event Fired 🔥")
                        self.loadFailed(from: from, adCallback: adCallback,number: index!)
                    },
                    onAdLoaded: adCallback.onAdLoaded,
                    onAdStarted: adCallback.onAdStarted,
                    onRewardSkip: adCallback.onAdLoaded,
                    onLoadFailed: {
                        let index : String? = localConfig!.failed?[localConfig!.tap![i].description]
                        if(index == nil){
                            print("nil Index Callback 🔥")
                            adCallback.onCloseEvent?()
                            return
                        }
                        print("On Load Fail Hit Event Fired 🔥")
                        self.failedCounter = self.failedCounter + 1
                        self.loadFailed(from: from, adCallback: adCallback,number: index!)                    }

                )
                if(number != "-1"){
                    let numberCallback = AdModuleWithCallBacks(
                        onCloseEvent: {
                            print("On Ad Close Number Callback  Event Fired 🔥")
                            self.failedCounter = 0
                            MultiAdsManager.shared.commonState.adLoader = false
                            adCallback.onCloseEvent?()
                        },
                        onFailed: {
                            let index : String? = localConfig!.failed?[number]
                            if(index == nil){
                                print("nil Index Number Callback  Callback 🔥")
                                adCallback.onCloseEvent?()
                                return
                            }
                            print("On Fail Number Callback Hit Event Fired 🔥")
                            self.loadFailed(from: from, adCallback: adCallback,number: index!)
                        },
                        onAdLoaded: adCallback.onAdLoaded,
                        onAdStarted: adCallback.onAdStarted,
                        onRewardSkip: adCallback.onAdLoaded,
                        onLoadFailed: {
                            let index : String? = localConfig!.failed?[number]
                            if(index == nil){
                                print("nil Index Number Callback  Callback 🔥")
                                adCallback.onCloseEvent?()
                                return
                            }
                            print("On Load Fail Number Callback  Hit Event Fired 🔥")
                            self.failedCounter = self.failedCounter + 1
                            self.loadFailed(from: from, adCallback: adCallback,number: index!)                    }

                    )
                    loadFromNumber(config: localConfig!, number: number, adCallback: numberCallback)
                   return
                }
                if CommonChangables.shared.routeIndex[from] == nil {
                    print(from + " Is Null Setting 0 By Default")
                    CommonChangables.shared.routeIndex[from] = 0
                } else {
                    /*
                     0 == 1
                     */
                    i = CommonChangables.shared.routeIndex[from]!
                    print(" Tap Index Count \(localConfig!.tap!.count - 1)")
                    print(" Tap Index  \(i)")
                    if i >= (localConfig!.tap!.count - 1) {
                        i = 0
                        print(from + " Is Full Setting 0 By Default")

                        CommonChangables.shared.routeIndex[from] = i
                    } else {
                        i = i + 1
                        print(from + " Is Exicuted Setting \(i) as Value")

                        CommonChangables.shared.routeIndex[from] = i
                    }
                }
                loadFromNumber(config: localConfig!, number: localConfig!.tap![i].description, adCallback: callback)
                return
            }
            adCallback.onCloseEvent?()
            print("Global Ad On Hit.....>")
            return
        }
        adCallback.onCloseEvent?()
        print("Last Case Hit.....>")
    }

    public func loadShowNative(from: String = "default") -> AnyView {
    var localConfig: AdConfigDataModel? = ServerConfig.sharedInstance.screenConfig?[from]
    print("✅ Config [loadNativeAds] Tap \(String(describing: localConfig?.native))")
    print("✅ Config [loadNativeAds]  \(String(describing: localConfig))")
    print("✅ Config [loadNativeAds] From :  \(from)")
    print("✅ Config [loadNativeAds] Congig :  \(ServerConfig.sharedInstance.screenConfig)")
    if localConfig == nil {
        localConfig = ServerConfig.sharedInstance.screenConfig?["default"]
        print("✅ Local Config [loadNativeAds]  \(String(describing: localConfig))")
    }

    if ServerConfig.sharedInstance.globalAdStatus {
        if localConfig!.showAds {
            switch localConfig?.native {
            case 1:
                let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.google] != nil
                if keyExists {
                    print("⚠️ [loadNativeAds] Google Native Key Exist")

                    return AnyView(ServerConfig.sharedInstance.loadAdNetwork![.google]!.getNativeAd(height: 200, width: 200, from: from))
                }
                print("⚠️ [loadNativeAds] No Key Exist")
                return  AnyView(VStack {})
            case 2:
                let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.appLovin] != nil
                if keyExists {
                    print("⚠️ [loadNativeAds] AppLovin Native Key Exist")

                    return AnyView(ServerConfig.sharedInstance.loadAdNetwork![.appLovin]!.getNativeAd(height: 200, width: 200, from: from))
                }
                print("⚠️ [loadNativeAds] No Key Exist")
                return  AnyView(VStack {})
            default:
                return  AnyView(VStack {})
            }
        }
    }
    return  AnyView(VStack {})
}
    
    public func loadShowBanner(from: String = "default") -> AnyView {
    var localConfig: AdConfigDataModel? = ServerConfig.sharedInstance.screenConfig?[from]
    print("✅ Config [loadBannerAds] Tap \(String(describing: localConfig?.native))")
    print("✅ Config [loadBannerAds]  \(String(describing: localConfig))")
    print("✅ Config [loadBannerAds] From :  \(from)")
    if localConfig == nil {
        localConfig = ServerConfig.sharedInstance.screenConfig?["default"]
        print("✅ Local Config [loadBannerAds]  \(String(describing: localConfig))")
    }

    if ServerConfig.sharedInstance.globalAdStatus {
        if localConfig!.showAds {
            switch localConfig?.banner {
            case 1:
                let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.google] != nil
                if keyExists {
                    print("⚠️ [loadBannerAds] Google Native Key Exist")

                    return AnyView(
                        HStack {
                            Spacer()
                            ServerConfig.sharedInstance.loadAdNetwork![.google]!.getBannerAd(from: from)
                            Spacer()
                        }
                    )
                }
                print("⚠️ [loadBannerAds] No Key Exist")
                return  AnyView(VStack {})
            case 2:
                let keyExists = ServerConfig.sharedInstance.loadAdNetwork?[.appLovin] != nil
                if keyExists {
                    print("⚠️ [loadBannerAds] AppLovin Native Key Exist")

                    return AnyView(ServerConfig.sharedInstance.loadAdNetwork![.appLovin]!.getBannerAd(from: from))
                }
                print("⚠️ [loadBannerAds] No Key Exist")
                return  AnyView(VStack {})
            default:
                return  AnyView(VStack {})
            }
        }
    }
    return  AnyView(VStack {})
}

}

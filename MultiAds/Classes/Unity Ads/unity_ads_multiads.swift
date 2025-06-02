// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UnityAds
@available(iOS 14.0, *)



@available(iOS 14.0, *)
public class UnityAdsMulti : @preconcurrency NetworkInterface{
    
    public init() {
        
    }
    public func initNetwork(onSdkInitialized: @escaping () -> Void) -> Bool {
        let configID: String? = ServerConfig.sharedInstance.adNetworkIds?["unity"]?.configId
    
        if(configID != nil){
            UnityAds.initialize(configID!)
            onSdkInitialized()
            return true
        }
        return false
    }
    
    @MainActor public func loadAndShowInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
        UnityInter.shared.adModuleCallBacks = adModuleCallBacks
        UnityInter.shared.loadAndShowInter()
       
    }
    
    @MainActor public func loadAndShowRewardAd(adModuleCallBacks: AdModuleWithCallBacks?) {
        UnityReward.shared.adModuleCallBacks = adModuleCallBacks
        UnityReward.shared.loadAndShowReward()
    }
    
    public func loadAndShowRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
      
    }
    
    public func getNativeAd(height: Double?, width: Double?, from: String?) -> AnyView {
        return AnyView(VStack{})
    }
    
    public func getBannerAd(from: String?) -> AnyView {
        return AnyView(VStack{})
    }
}

// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUICore
import AppLovinSDK


@available(iOS 14.0, *)
public class AppLovingNetworkInterface : @preconcurrency NetworkInterface{
    
    public init() {}
    
    @MainActor public func initNetwork(onSdkInitialized: @escaping () -> Void) -> Bool {
        ALPrivacySettings.setDoNotSell(true)

        var sdkKey = ServerConfig.sharedInstance.adNetworkIds?["applovin"]?.configId ?? ""
            MainMethods.shared.initAlSdk(sdkKey: sdkKey) {
                onSdkInitialized()
            }
            return true
    }
    
    @MainActor public func loadAndShowInterAd(adModuleCallBacks:AdModuleWithCallBacks?) {
        let inter = ALInter.shared
           inter.adModuleCallBacks = adModuleCallBacks
           inter.createInterstitialAd()
    }
    
    @MainActor public func loadAndShowRewardAd(adModuleCallBacks: AdModuleWithCallBacks?) {
        let rewards = ALReward.shared
           rewards.adModuleCallBacks = adModuleCallBacks
           rewards.createRewardedAd()
    }
    
    public func loadAndShowRewardInter(adModuleCallBacks: AdModuleWithCallBacks?) {
      
    }
    
    public func getNativeAd(height: Double?, width: Double?, from: String?) -> AnyView {
        return AnyView(AlNativeView())
    }
    
    @MainActor public func getBannerAd(from: String?) -> AnyView {
        return AnyView(AlBanner())
    }
    
   
    
}




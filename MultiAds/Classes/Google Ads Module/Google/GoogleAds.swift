//
//  GoogleAds.swift
//  testplugin
//
//  Created by Khusnud Zehra on 30/01/25.
//

import UIKit
import GoogleMobileAds
import SwiftUICore


@available(iOS 13.0, *)
public class GoogleAds : @preconcurrency NetworkInterface{
    public func initNetwork(onSdkInitialized: @escaping () -> Void) -> Bool {
        
        DispatchQueue.main.async {
           

            MobileAds.shared.start { status in

                let adapterStatuses = status.adapterStatusesByClassName
                     for adapter in adapterStatuses {
                       let adapterStatus = adapter.value
                       NSLog("Adapter Name: %@, Description: %@, Latency: %f", adapter.key,
                       adapterStatus.description, adapterStatus.latency)
                }
            }
          


        }
        onSdkInitialized()
        return true
    }
    
    @MainActor public func loadAndShowInterAd(adModuleCallBacks: AdModuleWithCallBacks?) {
        let inter = InterstitialAdGoogle.sharedInstance
        inter.adModuleCallBacks = adModuleCallBacks
        inter.loadInterstitial()
    }
    
    @MainActor public func loadAndShowRewardAd(adModuleCallBacks: AdModuleWithCallBacks?) {
        let rewards = RewardAd.sharedInstance
        rewards.adModuleCallBacks = adModuleCallBacks
        rewards.loadReward()
    }
    
    @MainActor public func loadAndShowRewardInter(adModuleCallBacks:AdModuleWithCallBacks?) {
        let rewards = RewardInterAd.sharedInstance
        rewards.adModuleCallBacks = adModuleCallBacks
        rewards.loadReward()
    }
    
    @MainActor public func getNativeAd(height: Double?, width: Double?, from: String?) -> AnyView {
        return AnyView(GoogleNativeAd(height: height ?? 350, width: width ?? 350 , from: from ?? "default"))
    }
    
    @MainActor public func getBannerAd(from: String?) -> AnyView {
        return AnyView(GoogleBannerAd(from: from ?? "default"))
    }
    
    
}

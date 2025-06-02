//
//  unity_reward.swift
//  unity_ads_multiads
//
//  Created by Khusnud Zehra on 06/02/25.
//

import Foundation
import UnityAds



@available(iOS 13.0, *)
class UnityReward : NSObject, UnityAdsShowDelegate, UnityAdsLoadDelegate {
    @MainActor static var shared: UnityReward = UnityReward(adModuleCallBacks: nil)

    var adModuleCallBacks: AdModuleWithCallBacks?
    
    
    public init(adModuleCallBacks: AdModuleWithCallBacks?) {
        self.adModuleCallBacks = adModuleCallBacks
    }
    

    func unityAdsAdLoaded(_ placementId: String) {
        print("Ad Loaded")
        let placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["unity"]?.rewardId
        UnityAds.show(rootController!, placementId:  placementId ?? "", showDelegate: self)
    
    }
    
    func unityAdsAdFailed(toLoad placementId: String, withError error: UnityAdsLoadError, withMessage message: String) {
        print("Ad Load Failed \(message)")
    }
    
    

    func loadAndShowReward() {
        let placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["unity"]?.rewardId

        if(placementId != nil){
            UnityAds.load(placementId!,loadDelegate: self)
        }else{
            print("No Placement Id")
        }
    }
    func unityAdsShowComplete(_ placementId: String, withFinish state: UnityAdsShowCompletionState) {
       
        print("On Ad Dismiss")
        adModuleCallBacks?.onCloseEvent?()
    }
    
    func unityAdsShowFailed(_ placementId: String, withError error: UnityAdsShowError, withMessage message: String) {
        print("Ad Show Failed \(message)")
      
        adModuleCallBacks?.onFailed?()
    }
    
    func unityAdsShowStart(_ placementId: String) {
        adModuleCallBacks?.onAdStarted?()
    }
    
    func unityAdsShowClick(_ placementId: String) {
        
    }
    
    
}

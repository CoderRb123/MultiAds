//
//  ALReward.swift
//  applovin_multiads
//
//  Created by Khusnud Zehra on 19/05/25.
//

import AppLovinSDK
import SwiftUI

@available(iOS 13.0, *)
public class ALReward : UIViewController, @preconcurrency  MARewardedAdDelegate
{
    
    @MainActor static var shared: ALReward = ALReward()
    var adModuleCallBacks: AdModuleWithCallBacks?
  var rewardedAd: MARewardedAd!
  var retryAttempt = 0.0

    public func createRewardedAd()
  {
    var placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["applovin"]?.rewardId
    placementId = "0971e0e0696bce3e"
    rewardedAd = MARewardedAd.shared(withAdUnitIdentifier:placementId ?? "")
    rewardedAd.delegate = self

    // Load the first ad
    rewardedAd.load()
  }

  // MARK: MAAdDelegate Protocol

    public func didLoad(_ ad: MAAd)
  {
      var placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["applovin"]?.rewardId
      rewardedAd.show(forPlacement: placementId)
      retryAttempt = 0
  }

    public func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError)
  {
      adModuleCallBacks?.onLoadFailed?()
  }

    public func didDisplay(_ ad: MAAd) {}

    public func didClick(_ ad: MAAd) {}

    public func didHide(_ ad: MAAd)
  {
      print("On Did Hide")
      adModuleCallBacks?.onCloseEvent?()
  }

    public func didFail(toDisplay ad: MAAd, withError error: MAError)
  {
     
      adModuleCallBacks?.onFailed?()
  }

  // MARK: MARewardedAdDelegate Protocol

    public func didRewardUser(for ad: MAAd, with reward: MAReward)
  {
      print("On Did User")
//      adModuleCallBacks?.onCloseEvent?()
  }
}

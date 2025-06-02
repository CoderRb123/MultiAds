//
//  ALInter.swift
//  applovin_multiads
//
//  Created by Khusnud Zehra on 19/05/25.
//


import AppLovinSDK
import SwiftUI

@available(iOS 13.0, *)
public class ALInter: UIViewController, @preconcurrency MAAdDelegate
{
    @MainActor static var shared: ALInter = ALInter()
    var adModuleCallBacks: AdModuleWithCallBacks?

    var interstitialAd: MAInterstitialAd!
    var retryAttempt = 0.0
   
    
    public func createInterstitialAd()
  {
    var placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["applovin"]?.interId
    interstitialAd = MAInterstitialAd(adUnitIdentifier: placementId ?? "")
    interstitialAd.delegate = self
    // Load the first ad
    interstitialAd.load()
  }

  // MARK: MAAdDelegate Protocol

    public func didLoad(_ ad: MAAd)
  {
    var placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["applovin"]?.interId
    placementId = "dd6ae7075e4cbfb9"
    interstitialAd.show(forPlacement: placementId)
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
      print("On Ad Dismiss")
      adModuleCallBacks?.onCloseEvent?()
   
  }

    public func didFail(toDisplay ad: MAAd, withError error: MAError)
  {
    // Interstitial ad failed to display. AppLovin recommends that you load the next ad.
    interstitialAd.load()
  }
}

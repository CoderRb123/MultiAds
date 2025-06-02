//
//  ALBanner.swift
//  applovin_multiads
//
//  Created by Khusnud Zehra on 20/05/25.
//

import SwiftUI
import AppLovinSDK

// MARK: Wrapper VIEW

@available(iOS 14.0, *)
struct AlBannerBase: UIViewRepresentable
{
  func makeUIView(context: Context) -> MAAdView
  {
    let config = MAAdViewConfiguration { builder in
      builder.adaptiveType = .anchored
    }
      var placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["applovin"]?.bannerId
    let adView = MAAdView(adUnitIdentifier: placementId ?? "", configuration: config)
    adView.delegate = context.coordinator

    // Set background color for banners to be fully functional
      adView.backgroundColor = .clear

    // Load the first Ad
    adView.loadAd()

    return adView
  }
    
    func updateUIView(_ uiView: MAAdView, context: Context) {}

      func makeCoordinator() -> Coordinator
      {
        Coordinator()
      }
 
}
@available(iOS 14.0, *)
extension AlBannerBase
{
  class Coordinator: NSObject, MAAdViewAdDelegate
  {
    // MARK: MAAdDelegate Protocol

    func didLoad(_ ad: MAAd) {}

    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        print("On Banner Failed to load: \(error.description)")
    }

    func didClick(_ ad: MAAd) {}

    func didFail(toDisplay ad: MAAd, withError error: MAError) {
        print("on Banner failed to display: \(error.description)")
    }

    // MARK: MAAdViewAdDelegate Protocol

    func didExpand(_ ad: MAAd) {}

    func didCollapse(_ ad: MAAd) {}

    // MARK: Deprecated Callbacks

    func didDisplay(_ ad: MAAd) { /* use this for impression tracking */ }
    func didHide(_ ad: MAAd) { /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */ }
  }
}


// MARK: MAIN VIEW

@available(iOS 14.0, *)
struct AlBanner: View
{
    
    public init(){
        
    }
  // Stretch to the width of the screen for banners to be fully functional
  let width = UIScreen.main.bounds.width

  // Get the anchored adaptive banner height
  let height = MAAdFormat.banner.adaptiveSize.height

  var body: some View {
      AlBannerBase()
      .frame(width: width, height: height)
  }
}

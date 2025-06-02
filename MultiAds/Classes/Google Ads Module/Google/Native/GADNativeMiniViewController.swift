//
//  GADNativeMiniViewController.swift
//  google_ads_multiads
//
//  Created by Khusnud Zehra on 22/05/25.
//

import UIKit
import GoogleMobileAds
import SwiftyJSON

// This sample code is based on Google's examples
// https://github.com/googleads/googleads-mobile-ios-examples/releases/tag/7.22

@available(iOS 14.0, *)
public class GADNativeMiniViewController: UIViewController {
    
    

  /// The height constraint applied to the ad view, where necessary.
    public var heightConstraint: NSLayoutConstraint?

  /// The ad loader. You must keep a strong reference to the GADAdLoader during the ad loading
  /// process.
    public var adLoader: AdLoader!

  /// The native ad view that is being presented.
    public var nativeAdView: NativeAdView!

  /// The ad unit ID.
    public  let adUnitID = ServerConfig.sharedInstance.adNetworkIds?["google"]?.bannerId ?? ""

    public override func viewDidLoad() {
    super.viewDidLoad()

    guard
    let nibObjects = Bundle(for: type(of: self)).loadNibNamed("SmallAdmobNative", owner: nil, options: nil),
      let adView = nibObjects.first as? NativeAdView
    else {
      print("Could not load nib file for adView")
        return
    }
    setAdView(adView)
    refreshAd()
  }

    public  func setAdView(_ view: NativeAdView) {

    nativeAdView = view
    self.view.addSubview(nativeAdView)
    nativeAdView.translatesAutoresizingMaskIntoConstraints = false

    // Layout constraints for positioning the native ad view to stretch the entire width and height
    // of the nativeAdPlaceholder.
    let viewDictionary = ["_nativeAdView": nativeAdView!]
    self.view.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[_nativeAdView]|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
    )
    self.view.addConstraints(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[_nativeAdView]|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
    )
  }

  // MARK: - Actions

  /// Refreshes the native ad.
    public func refreshAd() {
        print("AdMob Small Native Id :- \(adUnitID)")
        adLoader = AdLoader(
        adUnitID: adUnitID, rootViewController: self,
      adTypes: [.native], options: nil)
      adLoader.delegate = self
        adLoader.load(Request())
  }

 
}



@available(iOS 14.0, *)
extension GADNativeMiniViewController: @preconcurrency NativeAdLoaderDelegate {

    public func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {

    // Set ourselves as the native ad delegate to be notified of native ad events.
    nativeAd.delegate = self

    // Deactivate the height constraint that was set when the previous video ad loaded.
    heightConstraint?.isActive = false

    // Populate the native ad view with the native ad assets.
    // The headline and mediaContent are guaranteed to be present in every native ad.
    (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
//    nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent

   
    
    // These assets are not guaranteed to be present. Check that they are before
    // showing or hiding them.
//    (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
//    nativeAdView.bodyView?.isHidden = nativeAd.body == nil

    
    
    (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
    nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

    (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
    nativeAdView.iconView?.isHidden = nativeAd.icon == nil

//    (nativeAdView.starRatingView as? UIImageView)?.image = imageOfStars(from: nativeAd.starRating)
//    nativeAdView.starRatingView?.isHidden = nativeAd.starRating == nil

    (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
    nativeAdView.storeView?.isHidden = nativeAd.store == nil

//    (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
//    nativeAdView.priceView?.isHidden = nativeAd.price == nil

    (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
    nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

    // In order for the SDK to process touch events properly, user interaction should be disabled.
    nativeAdView.callToActionView?.isUserInteractionEnabled = false

    // Associate the native ad view with the native ad object. This is
    // required to make the ad clickable.
    // Note: this should always be done after populating the ad views.
    nativeAdView.nativeAd = nativeAd
  }

    public func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
    print("\(adLoader) Mini failed with error: \(error.localizedDescription)")
  }
}

// MARK: - GADNativeAdDelegate implementation

@available(iOS 14.0, *)
extension GADNativeMiniViewController: @preconcurrency NativeAdDelegate {

    public nonisolated func nativeAdDidRecordClick(_ nativeAd: NativeAd) {
    print("\(#function) Mini called")
  }

    public func nativeAdDidRecordImpression(_ nativeAd: NativeAd) {
    print("\(#function) Mini  called")
  }

    public func nativeAdWillPresentScreen(_ nativeAd: NativeAd) {
    print("\(#function)Mini  called")
  }

    public func nativeAdWillDismissScreen(_ nativeAd: NativeAd) {
    print("\(#function) called")
  }

    public func nativeAdDidDismissScreen(_ nativeAd: NativeAd) {
    print("\(#function) Mini called")
  }

    public func nativeAdIsMuted(_ nativeAd: NativeAd) {
    print("\(#function) Mini called")
  }
}

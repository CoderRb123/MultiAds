//
//  unity_banner.swift
//  unity_ads_multiads
//
//  Created by Khusnud Zehra on 21/05/25.
//


import UnityAds
import SwiftUI

class UnityBanner :NSObject, UADSBannerViewDelegate{
    
    public var bannerAdView: UADSBannerView?
    public var bannerSize = CGSize(width: 320, height: 50)

    
    @MainActor func showBannerAd(from viewController: UIViewController, placementId: String) {
           
           
        let banner = UADSBannerView(placementId: placementId, size: bannerSize)
        banner.load()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.delegate = self
        viewController.view.addSubview(banner)
        
        NSLayoutConstraint.activate([
            banner.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor),
            banner.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor)
        ])
        
        self.bannerAdView = banner
           
          
       }

}

//
//  NetworkInterface.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 30/01/25.
//

import Foundation
import SwiftUICore
import UIKit

@available(iOS 14.0, *)
public protocol NetworkInterface {
    
    func initNetwork(onSdkInitialized: @escaping () -> Void) -> Bool
    // Inter Ads
    func loadAndShowInterAd(adModuleCallBacks: AdModuleWithCallBacks?)
    // Reward Ads
    func loadAndShowRewardAd(adModuleCallBacks: AdModuleWithCallBacks?)

    // Reward Inter
    func loadAndShowRewardInter(adModuleCallBacks: AdModuleWithCallBacks?)

    func getNativeAd(height: Double?, width: Double?, from: String?) -> AnyView

    func getBannerAd(from: String?) -> AnyView
}

@available(iOS 14.0, *)
public struct ViewWrapper {
    public init(v: any View) {
        self.v = v
    }

    public let v: any View
}




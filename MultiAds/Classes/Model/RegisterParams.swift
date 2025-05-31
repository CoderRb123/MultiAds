//
//  RegisterParams.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 30/01/25.
//

import Foundation
import UIKit

public class ApiRegister {
    public var iosKey: String?
    public var androidKey: String?

    public init(iosKey: String? = nil, androidKey: String? = nil) {
        self.iosKey = iosKey
        self.androidKey = androidKey
    }
}

@available(iOS 13.0, *)
public class RegisterAppParameters {
    public var appVersion: String
    public var apiKey: ApiRegister
    public var rewardType: String
    public var onError: (String) -> Void
    public var onComplete: (Any) -> Void
    public var onUpdateLaunch: (String) -> Void
    public var requiredAdNetworks: [NetworkType: NetworkInterface]?

    public init(appVersion: String = "1.0", rewardType: String = "2",  apiKey: ApiRegister, onUpdateLaunch: @escaping (String) -> Void, onError: @escaping (String) -> Void, onComplete: @escaping (Any) -> Void, requiredAdNetworks: [NetworkType: NetworkInterface]? = nil) {
        self.appVersion = appVersion
        self.rewardType = rewardType
       
        self.apiKey = apiKey
        self.onUpdateLaunch = onUpdateLaunch
        self.onError = onError
        self.onComplete = onComplete
        self.requiredAdNetworks = requiredAdNetworks
    }
    
    
    
}

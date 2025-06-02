//
//  ServerConfig.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 30/01/25.
//
import Observation


import SwiftyJSON
import SwiftUI





@available(iOS 14.0, *)
public class ServerConfig {
    static  public let sharedInstance = ServerConfig()

    public init() { }

    public var configJson: JSON?
    public var onesignalApiKey: String = ""
    public var globalAdStatus: Bool = false
    public var screenConfig: [String: AdConfigDataModel]?
    public var adNetworkIds: [String: AdNetworkIds]?
    public var initAdNetworks: [String] = []
    public var extraConfig: [String: Any]?
    public var updateDialogConfig: [String: Any]?
    public var loadAdNetwork: [NetworkType: NetworkInterface]?
    
  
}


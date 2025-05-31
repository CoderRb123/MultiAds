//
//  NetworkToIndexMapper.swift
//  CommonInterface_ios
//
//  Created by Khusnud Zehra on 20/11/24.
//





class NetworkToIndexMapper {
    static func getNetworkType(network: String) -> NetworkType? {
        return NetworkType.fromString(network)
    }
    
    static func getAdType(adIndex: String) -> AdsType? {
        return AdsType.fromString(adIndex)
    }
}

//
//  DeviceMethods.swift
//  CommonInterface_ios
//
//  Created by Khusnud Zehra on 23/12/24.
//


import Foundation
import UIKit
import KeychainSwift


class DeviceMethods {
    
   
    func getDevicePublicKey()-> String {
        let uuid = UUID().uuidString
        let keychain = KeychainSwift()

        let token : String? =  keychain.get("device_public_key")
        if(token != nil) {
            print("MultiAds Interface Token Founded:")
            return token ?? uuid
        }else{
            
            print("MultiAds Interface Token Null:")

            keychain.set(uuid, forKey: "device_public_key")
            
            return uuid
        }
        
    }
    
    @MainActor func getDeviceId() -> String? {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    @MainActor func getDeviceName() -> String? {
        return UIDevice.current.name
    }
    
    @MainActor func getDeviceModel() -> String? {
        return UIDevice.current.model
    }
    
    @MainActor func getDeviceSystemName() -> String? {
        return UIDevice.current.systemVersion
    }
    
    var appName: String {
            Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown"
        }
        
        var package: String {
            Bundle.main.bundleIdentifier ?? "Unknown"
        }
        
        var version: String {
            Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
        }
        
        var buildNumber: String {
            Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
        }
}

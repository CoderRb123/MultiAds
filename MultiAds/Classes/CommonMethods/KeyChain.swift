////
////  keychain.swift
////  MultiAdsInterface
////
////  Created by Khusnud Zehra on 17/01/25.
////
//
//import Security
//import Foundation
//
//class KeyChain {
//    
//    static func insertToken(_ data: Data, service: String, account: String) {
//        
//        // Create query
//        let query = [
//            kSecValueData: data,
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrService: service,
//            kSecAttrAccount: account,
//        ] as CFDictionary
//        
//        // Add data in query to keychain
//        let status = SecItemAdd(query, nil)
//        
//        if status != errSecSuccess {
//            // Print out the error
//            print("Error: \(status)")
//        }
//    }
//  
//    
//    static func getToken(service: String, account: String) -> Data? {
//        
//        let query = [
//            kSecAttrService: service,
//            kSecAttrAccount: account,
//            kSecClass: kSecClassGenericPassword,
//            kSecReturnData: true
//        ] as CFDictionary
//        
//        var result: AnyObject?
//        SecItemCopyMatching(query, &result)
//        
//        return (result as? Data)
//    }
//    
//}

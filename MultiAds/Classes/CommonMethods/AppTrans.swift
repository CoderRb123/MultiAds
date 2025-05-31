//
//  AppTrans.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 17/01/25.
//

import AdSupport
import AppTrackingTransparency

@available(iOS 13.0, *)
class AppTrans {
    public init() {
    }

    public func getTrackingIdentifierWithRequest() -> UUID? {
       
        var id: UUID?
        self.requestTrackingAccess {
            id =  self.getTrackingIdentifier()
        }
        return id
    }

    public func isTrackingAccessAvailable() -> Bool {
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("On authorized")
                return true
            case .denied:
                print("Denied")
                return false
            case .notDetermined:
                print("Not Determined")
                return false
            case .restricted:
                print("Restricted")
                return false
            @unknown default:
                return false
            }
        } else {
            return false
        }
    }

    public func requestTrackingAccess(onGranted: (() -> Void)? = nil) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Log: ATTrackingManager request successful")
                    onGranted?()
                case .denied:
                    print("Denied")
                   
                case .notDetermined:
                    print("Not Determined")
                  
                case .restricted:
                    print("Restricted")
                    
                
                @unknown default:
                    print("Unknown")
                  
                    break
                }
            }
        }
    }

    public func getTrackingIdentifier() -> UUID? {
        if isTrackingAccessAvailable() {
            return ASIdentifierManager.shared().advertisingIdentifier
        }
        return nil
    }
    
   

}

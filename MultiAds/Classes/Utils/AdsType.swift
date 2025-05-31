//
//  AdsType.swift
//  CommonInterface_ios
//
//  Created by Khusnud Zehra on 23/12/24.
//

import UIKit

enum AdsType {
    case inter
    case reward
    case rewardInter
   
    
    // Static function to convert string to NetworkType
    static func fromString(_ value: String) -> AdsType {
        switch value {
        case "0": return .inter
        case "1": return .reward
        case "2": return .rewardInter
        default: return .inter
        }
    }
    var stringValue: String {
            switch self {
            case .inter: return "0"
            case .reward: return "1"
            case .rewardInter: return "2"
          
            }
        }
}




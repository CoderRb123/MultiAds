import UIKit
public enum NetworkType {
    case none
    case google
    case unity
    case yodoMas
    case ironSource
    case facebook
    case appLovin
    
    
    public  static func fromName(_ value: String) -> NetworkType {
        switch value {
        case "google": return .google
        case "unity": return .unity
        case "yodo": return .yodoMas
        case "ironsource": return .ironSource
        case "facebook": return .facebook
        case "appLovin": return .appLovin
        default: return .none
        }
    }
    
    // Static function to convert string to NetworkType
    public  static func fromString(_ value: String) -> NetworkType {
        switch value {
        case "0": return .none
        case "1": return .google
        case "2": return .unity
        case "3": return .yodoMas
        case "4": return .ironSource
        case "5": return .facebook
        case "6": return .appLovin
        default: return .none
        }
    }
    public  var stringValue: String {
            switch self {
            case .none: return "0"
            case .google: return "1"
            case .unity: return "2"
            case .yodoMas: return "3"
            case .ironSource: return "4"
            case .facebook: return "5"
            case .appLovin: return "6"
            }
        }
    
    public  var stringName: String {
            switch self {
            case .none: return "none"
            case .google: return "google"
            case .unity: return "unity"
            case .yodoMas: return "yodo"
            case .ironSource: return "ironsource"
            case .facebook: return "facebook"
            case .appLovin: return "appLovin"
            }
        }
}



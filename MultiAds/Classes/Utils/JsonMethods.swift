//
//  JsonMethods.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 30/01/25.
//

import Foundation



class JsonMethods {
    
    
    public init () {
        
    }
    
    public func parseScreenData(screenData: [String: Any]) -> [String: AdConfigDataModel]? {
        if screenData.isEmpty {
            return nil
        }
      
        var adConfigDataModel: [String: AdConfigDataModel] = [:]
        for (key, value) in screenData {
            adConfigDataModel[key] = AdConfigDataModel.fromJson(data: value as! [String : Any])
        }
        print("✅ Screen Data")
        print(adConfigDataModel.count)
        print(adConfigDataModel)
        return adConfigDataModel
    }
    
    public func parseAdNetworkIds(adNetworkIds: [String: Any]) -> [String: AdNetworkIds]? {
        if adNetworkIds.isEmpty {
            return nil
        }
        return adNetworkIds.mapValues { AdNetworkIds.fromJson(data:$0 as! [String : Any]) }
    }

    
    
    public func convertToDictionary(jsonString: String) -> [String: Any]? {
      
           let fixedString = jsonString.replacingOccurrences(of: "\\", with: "")

          
           // Step 2: Convert to Data
           guard let jsonData = fixedString.data(using: .utf8) else { return nil }

           // Step 3: Parse JSON
           do {
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
               return jsonObject as? [String: Any]
           } catch {
               print("Error parsing JSON: \(error.localizedDescription)")
               return nil
           }
    }
    
    public func convertToArray(jsonString: String) -> [String]? {
      
           let fixedString = jsonString.replacingOccurrences(of: "\\", with: "")

          
           // Step 2: Convert to Data
           guard let jsonData = fixedString.data(using: .utf8) else { return nil }

           // Step 3: Parse JSON
           do {
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
               return jsonObject as? [String]
           } catch {
               print("Error parsing Array: \(error.localizedDescription)")
               return nil
           }
    }
    
    public func convertToArrayAny(jsonString: String) -> [Any]? {
      
           let fixedString = jsonString.replacingOccurrences(of: "\\", with: "")

          
           // Step 2: Convert to Data
           guard let jsonData = fixedString.data(using: .utf8) else { return nil }

           // Step 3: Parse JSON
           do {
               let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
               return jsonObject as? [Any]
           } catch {
               print("Error parsing Array: \(error.localizedDescription)")
               return nil
           }
    }

}

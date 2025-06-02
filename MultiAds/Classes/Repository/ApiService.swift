//
//  ApiService.swift
//  CommonInterface_ios
//
//  Created by Khusnud Zehra on 15/01/25.
//

import Foundation
import SwiftyJSON
import AdSupport
import SwiftUI

@available(iOS 14.0, *)
public class ApiService {
    
    @ObservedObject var networkConst: NetworkConst = NetworkConst.shared
    
    func registerDevice(body: [String: String],onComplete: @escaping (Any) -> Void,onError: @escaping (String) -> Void) {
        guard let url = URL(string: networkConst.networkLink.device_register_url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData

          URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        onError(error.localizedDescription)
                    }
                    return
                }
                DispatchQueue.main.async {
                    if(data != nil){
                        let json = try? JSON(data: data!)
                        if(json?["success"].boolValue ?? false){
                            print("Multi Ads Response Success")
                            let deviceId =  json!["data"]["device_public_key"].string
                            onComplete(deviceId ?? "")
                        }
                    }else{
                        print("Multi Ads Response is nil")
                    }
                }
            }.resume()
        } catch {
            DispatchQueue.main.async {
                onError(error.localizedDescription)
            }
        }
    }
    
    
    
    func getServerConfigration(apiKey: String,appVersion:String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void) {
        
        
        let device_public_key: String = DeviceMethods().getDevicePublicKey()
        print("MultiAds:[_fetchConfig]->Checking Device Public Key[⚠️] : \(device_public_key)");
        print("MultiAds:[_fetchConfig]->Checking Api Key[⚠️] : \(apiKey)");
        print("MultiAds:[_fetchConfig]->Checking App Version[⚠️] : \(appVersion)");
        print("MultiAds:[_fetchConfig]->Checking App Url[⚠️] : \(  networkConst.networkLink.get_config_url + apiKey + "/" + appVersion + "/" + device_public_key)");
        guard let url = URL(string:  networkConst.networkLink.get_config_url + apiKey + "/" + appVersion + "/" + device_public_key) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(device_public_key, forHTTPHeaderField: "device-public-key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Check 1 Completed[✅]");

            if let error = error {
                  DispatchQueue.main.async {
                      print("MultiAds:[_fetchConfig]->Error[❌] : \(error.localizedDescription)");
                      onError(error.localizedDescription)
                  }
                  return
              }
            print("Check 2 Completed[✅]");
              DispatchQueue.main.async {
                  print("Check 3 Completed[✅]");
                  if(data != nil){
                      print("Check 4 Completed[✅]");

                      let json = try? JSON(data: data!)
                      if(json?["success"].boolValue ?? false){
                          print("MultiAds:[_fetchConfig]->Success[✅]");
                          onComplete(json?["data"])
                      }else{
                          print("Check 5 Completed[✅] \(json)");
                      }
                  }else{
                      print("Check 6 Completed[✅]");

                      print("MultiAds:[_fetchConfig]->Error[❌]");
                  }
              }
          }.resume()
    }
    
    
    
    
    func getNormalReward(rewardType: String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void) {
        
        
        let device_public_key: String = DeviceMethods().getDevicePublicKey()
       
        guard let url = URL(string: networkConst.networkLink.reward_normal_url + device_public_key + "/" + rewardType + "/normal" ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(device_public_key, forHTTPHeaderField: "device-public-key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("NormalReward 1 Completed[✅]");
            if let error = error {
                  DispatchQueue.main.async {
                      print("MultiAds:[_fetchConfig]->Error[❌] : \(error.localizedDescription)");
                      onError(error.localizedDescription)
                  }
                  return
              }
            print("NormalReward 2 Completed[✅]");
              DispatchQueue.main.async {
                  print("NormalReward 3 Completed[✅]");
                  if(data != nil){
                      print("NormalReward 4 Completed[✅]");
                      let json = try? JSON(data: data!)
                      if(json?["success"].boolValue ?? false){
                          print("NormalReward:[json]->Success[✅] \(String(describing: json))");
                          onComplete(json?["data"])
                      }else{
                          print("NormalReward 5 Completed[✅] \(String(describing: json))");
                      }
                  }else{
                      print("NormalReward 6 Completed[✅]");

                      print("NormalReward:[_fetchConfig]->Error[❌]");
                  }
              }
          }.resume()
    }
    
    
    func getDateGroupedReward(rewardType: String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void) {
        
        
        let device_public_key: String = DeviceMethods().getDevicePublicKey()
       
        guard let url = URL(string: networkConst.networkLink.reward_normal_url + device_public_key + "/" + rewardType + "/grouped" ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(device_public_key, forHTTPHeaderField: "device-public-key")
          
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("NormalReward 1 Completed[✅]");
            if let error = error {
                  DispatchQueue.main.async {
                      print("MultiAds:[_fetchConfig]->Error[❌] : \(error.localizedDescription)");
                      onError(error.localizedDescription)
                  }
                  return
              }
            print("NormalReward 2 Completed[✅]");
              DispatchQueue.main.async {
                  print("NormalReward 3 Completed[✅]");
                  if(data != nil){
                      print("NormalReward 4 Completed[✅]");
                      let json = try? JSON(data: data!)
                    
                      if(json?["success"].boolValue ?? false){
                          print("NormalReward:[json]->Success[✅] \(String(describing: json))");
                          onComplete(json?["data"])
                      }else{
                          print("NormalReward 5 Completed[✅] \(String(describing: json))");
                      }
                  }else{
                      print("NormalReward 6 Completed[✅]");

                      print("NormalReward:[_fetchConfig]->Error[❌]");
                  }
              }
          }.resume()
    }
    
    
    func getStatusGroupedReward(rewardType: String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void) {
        
        
        let device_public_key: String = DeviceMethods().getDevicePublicKey()
        
        let urlString = networkConst.networkLink.reward_normal_url + device_public_key + "/" + rewardType + "/categorized"
       
        guard let url = URL(string:urlString ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(device_public_key, forHTTPHeaderField: "device-public-key")
        print(urlString)
        print(device_public_key)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Status Grouped 1 Completed[✅]");
            if let error = error {
                  DispatchQueue.main.async {
                      print("MultiAds:[_fetchConfig]->Error[❌] : \(error.localizedDescription)");
                      onError(error.localizedDescription)
                  }
                  return
              }
            print("Status Grouped 2 Completed[✅]");
              DispatchQueue.main.async {
                  print("Status Grouped 3 Completed[✅]");
                  if(data != nil){
                      print("Status Grouped 4 Completed[✅]");
                      let json = try? JSON(data: data!)
                      if(json?["success"].boolValue ?? false){
                          print("Status Grouped:[json]->Success[✅] \(String(describing: json))");
                          onComplete(json)
                      }else{
                          print("Status Grouped 5 Completed[✅] \(String(describing: json))");
                      }
                  }else{
                      print("Status Grouped 6 Completed[✅]");

                      print("Status Grouped:[_fetchConfig]->Error[❌]");
                  }
              }
          }.resume()
    }
    
    
    func fetchRewardDetails(rewardIds: String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void) {
        
        
        let device_public_key: String = DeviceMethods().getDevicePublicKey()
       
        guard let url = URL(string: networkConst.networkLink.reward_details_url + device_public_key + "/" + rewardIds  ) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(device_public_key, forHTTPHeaderField: "device-public-key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Reward Detail 1 Completed[✅]");
            if let error = error {
                  DispatchQueue.main.async {
                      print("MultiAds:[_fetchConfig]->Error[❌] : \(error.localizedDescription)");
                      onError(error.localizedDescription)
                  }
                  return
              }
            print("Reward Detail 2 Completed[✅]");
              DispatchQueue.main.async {
                  print("Reward Detail3 Completed[✅]");
                  if(data != nil){
                      print("Reward Detail 4 Completed[✅]");
                      let json = try? JSON(data: data!)
                      if(json?["success"].boolValue ?? false){
                          print("Reward Detail:[json]->Success[✅] \(String(describing: json))");
                          onComplete(json)
                      }else{
                          print("Reward Detail 5 Completed[✅] \(String(describing: json))");
                      }
                  }else{
                      print("Reward Detail 6 Completed[✅]");

                      print("Reward Detail:[_fetchConfig]->Error[❌]");
                  }
              }
          }.resume()
    }
    
    func claimReward(rewardIds: String,onComplete: @escaping (_ url:String) -> Void,onError: @escaping (String) -> Void) {
        do {
 
            let device_public_key: String = DeviceMethods().getDevicePublicKey()
            let device_iifd: String = ASIdentifierManager.shared().advertisingIdentifier.uuidString
           
            guard let url = URL(string: networkConst.networkLink.reward_claim_url   ) else { return }
            let body = [
                "reward_id": rewardIds,
                "reward_type_id": ServerConfig.sharedInstance.configJson?["reward_type_id"].stringValue ?? "1",
                "device_public_key": device_public_key,
                "device_iifd": device_iifd,
                "appName": DeviceMethods().appName,
                "package":  DeviceMethods().package,
                "version":  DeviceMethods().version ,
                "buildNumber":  DeviceMethods().buildNumber,
            ]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(device_public_key, forHTTPHeaderField: "device-public-key")
            URLSession.shared.dataTask(with: request) { data, response, error in
                print("Claim Reward 1 Completed[✅]");
                if let error = error {
                      DispatchQueue.main.async {
                          print("MultiAds:[_fetchConfig]->Error[❌] : \(error.localizedDescription)");
                          onError(error.localizedDescription)
                      }
                      return
                  }
                print("Claim Reward 2 Completed[✅]");
                  DispatchQueue.main.async {
                      print("Claim Reward Completed[✅]");
                      if(data != nil){
                          print("Claim Reward Completed[✅]");
                          let json = try? JSON(data: data!)
                          if(json?["success"].boolValue ?? false){
                              print("Claim Reward:[json]->Success[✅] \(String(describing: json))");
                              onComplete(json?["link"].stringValue ?? "")
                          }else{
                              print("Claim Reward 5 Completed[✅] \(String(describing: json))");
                          }
                      }else{
                          print("Claim Reward 6 Completed[✅]");

                          print("Claim Reward:[_fetchConfig]->Error[❌]");
                      }
                  }
              }.resume()
        } catch {
            onError(error.localizedDescription)
        }
    }
}

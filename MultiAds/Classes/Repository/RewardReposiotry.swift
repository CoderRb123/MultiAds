//
//  RewardReposiotry.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 31/01/25.
//

import SwiftyJSON

@available(iOS 14.0, *)
public class RewardReposiotry {
    let apiService: ApiService = ApiService()
    

    public init(){}
    
    
    public func getReward(rewardType:String,onComplete: @escaping (_ data:[JSON?]) -> Void,onError: @escaping (String) -> Void){
        
         apiService.getNormalReward(rewardType: rewardType) { data in
             onComplete( data?.arrayValue ?? [])
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    
    public func getDateGroupedReward(rewardType:String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void){
        
         apiService.getDateGroupedReward(rewardType: rewardType) { data in
             onComplete( data)
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    public func getStatusGroupedReward(rewardType:String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void){
        
         apiService.getStatusGroupedReward(rewardType: rewardType) { data in
             onComplete(data)
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    
    public func fetchRewardDetail(rewardId:String,onComplete: @escaping (_ data:JSON?) -> Void,onError: @escaping (String) -> Void){
        
        apiService.fetchRewardDetails(rewardIds: rewardId) { data in
             onComplete(data)
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    
    public func claimReward(rewardId:String,onComplete: @escaping (_ url:String) -> Void,onError: @escaping (String) -> Void){
        
        apiService.claimReward(rewardIds: rewardId) { data in
            onComplete(data)
        } onError: { ErrorString in
          
            onError(ErrorString)
            print("⚠️ Error : \(ErrorString)")
        }

    }
    
    
}

import ObjectiveC
import GoogleMobileAds
@available(iOS 13.0, *)
public class RewardAd: NSObject, FullScreenContentDelegate {
    
    @MainActor public static let sharedInstance = RewardAd(adModuleCallBacks: nil)
   
    public var adModuleCallBacks:AdModuleWithCallBacks?
   
    public   init(adModuleCallBacks: AdModuleWithCallBacks?) {
       self.adModuleCallBacks = adModuleCallBacks
     }
   
    public var reward: RewardedAd?
  

    
    @MainActor  public func loadReward() {
        print("Google Reward Loading Started 🔥")
        let request = Request()
        RewardedAd.load(with: ServerConfig.sharedInstance.adNetworkIds?["google"]?.rewardId ?? "", request: request, completionHandler: { [self] ad, error in
            
            if ad != nil { reward = ad }
            reward?.fullScreenContentDelegate = self
            showRewardAd()
        })
    }
    
    @MainActor public func showRewardAd() {
        print("Google Rewards Show Triggered 🔥")
        if(reward == nil){
            adModuleCallBacks?.onFailed?()
            return
        }
         if let root = rootController {
            reward?.present(from: root){
        }
        }
    }
    
    
    public  func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
       print("Google Reward Ad Failed ❌")
       adModuleCallBacks?.onFailed?()
   }
   
   
    public func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
     
       print("Google Reward Ad Presented🔥")
       adModuleCallBacks?.onAdStarted?()
     }
   
    public func adWillDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
       print("Google Reward Will Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
}



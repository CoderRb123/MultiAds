import ObjectiveC
import GoogleMobileAds
@available(iOS 13.0, *)
class RewardInterAd: NSObject, FullScreenContentDelegate {
    
    @MainActor public static let sharedInstance = RewardInterAd(adModuleCallBacks: nil)
   
    public var adModuleCallBacks:AdModuleWithCallBacks?
   
    public   init(adModuleCallBacks: AdModuleWithCallBacks?) {
       self.adModuleCallBacks = adModuleCallBacks
     }
    public var reward: RewardedInterstitialAd?


//    override init() {
//        super.init()
//        loadReward()
//    }
    
    @MainActor public func loadReward() {
        
        print("Google Reward Inter Loading Started 🔥")
        let request = Request()
        RewardedInterstitialAd.load(with: ServerConfig.sharedInstance.adNetworkIds?["google"]?.interRewardId  ?? "", request: request, completionHandler: { [self] ad, error in
            
            if ad != nil { reward = ad }
            reward?.fullScreenContentDelegate = self
            showRewardAd()
        })
       
    }
    
    @MainActor   public  func showRewardAd() {
        if(reward == nil){
            adModuleCallBacks?.onFailed?()
            return
        }
        if let root = rootController {
            print("Google Rewards Inter Show Triggered 🔥")
            reward?.present(from: root){

            }
        }
    }
    
    public  func ad(_ ad: any FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: any Error) {
       print("Google Reward Inter Ad Failed ❌")
       adModuleCallBacks?.onFailed?()
   }
   
   
    public func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
     
       print("Google Reward Inter Ad Presented🔥")
       adModuleCallBacks?.onAdStarted?()
     }
   
   
    public func adWillDismissFullScreenContent(_ ad: any FullScreenPresentingAd) {
       print("Google Reward Inter Will Dismissed 🔥")
        reward = nil
       adModuleCallBacks?.onCloseEvent?()
   }
}



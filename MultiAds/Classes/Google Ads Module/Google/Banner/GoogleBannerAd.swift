//
//  GoogleBannerAd.swift
//  google_ads_multiads
//
//  Created by Khusnud Zehra on 21/05/25.
//

import GoogleMobileAds
import SwiftUI

@available(iOS 14.0, *)
public struct BannerViewPrivate : View {
    public var body:  some  View {
        HStack {
            Spacer()
            BannerViewContainer(AdSizeBanner)
                .frame(width: AdSizeBanner.size.width,
                               height: AdSizeBanner.size.height)
            Spacer()
        }
           
    }
}

@available(iOS 14.0, *)
public struct GoogleBannerAd: View {
  

    public var from:String
    

    
    @State var adLoader: Bool = false
    @State public var config:AdConfigDataModel?

    public init(from: String = "default") {
        self.from = from
       
    }
    
    public func configration() {
        self.adLoader = true
        let defaultConfig:AdConfigDataModel? = ServerConfig.sharedInstance.screenConfig?["default"]
        print("fething from : \(self.from)")
        let server:AdConfigDataModel? = ServerConfig.sharedInstance.screenConfig?[self.from]
        
        print("fething server object : \(String(describing: server ?? nil))")
        print("fething default object : \(String(describing: defaultConfig ?? nil))")

        if(server != nil){
            self.config = server!
        }else{
            self.config = defaultConfig!

        }
        self.doLater()
    }
    public func doLater (){
       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           DispatchQueue.main.async {
               self.adLoader = false
           }
      }
    }
    public var body: some View {
   
        Group {
            if(adLoader || config == nil){
                VStack {
                 
                } .frame(width: 0,height: 0)
                    .padding(.zero)
                    
            }else{
                if(!ServerConfig.sharedInstance.globalAdStatus){
                    VStack {}
                        .frame(width: 0,height: 0)
                        .padding(.zero)
                }else{
                    if(config!.showAds){
                        BannerViewPrivate()
    
                    }else{
                        VStack {}
                            .frame(width: 0,height: 0)
                            .padding(.zero)
                    }
                }
            }
           
        }
       
        .onAppear {
            configration()
        }

  
  }
}

@available(iOS 14.0, *)

// [START create_banner_view]
private struct BannerViewContainer: UIViewRepresentable {
    let adSize: AdSize

  init(_ adSize: AdSize) {
    self.adSize = adSize
  }

  func makeUIView(context: Context) -> UIView {
    // Wrap the GADBannerView in a UIView. GADBannerView automatically reloads a new ad when its
    // frame size changes; wrapping in a UIView container insulates the GADBannerView from size
    // changes that impact the view returned from makeUIView.
    let view = UIView()
    view.addSubview(context.coordinator.bannerView)
    return view
  }

  func updateUIView(_ uiView: UIView, context: Context) {
    context.coordinator.bannerView.adSize = adSize
  }

  func makeCoordinator() -> BannerCoordinator {
    return BannerCoordinator(self)
  }
  // [END create_banner_view]

  // [START create_banner]
    @MainActor class BannerCoordinator: NSObject, BannerViewDelegate {

    private(set) lazy var  bannerView: BannerView = {
      let banner = BannerView(adSize: parent.adSize)
      let adUnitID = ServerConfig.sharedInstance.adNetworkIds?["google"]?.bannerId

      // [START load_ad]
      banner.adUnitID = adUnitID ?? "ca-app-pub-3940256099942544/2435281174"
      banner.load(Request())
      // [END load_ad]
      // [START set_delegate]
      banner.delegate = self
      // [END set_delegate]
      return banner
    }()

    let parent: BannerViewContainer

    init(_ parent: BannerViewContainer) {
      self.parent = parent
    }
    // [END create_banner]

    // MARK: - GADBannerViewDelegate methods

    func bannerViewDidReceiveAd(_ bannerView: BannerView) {
      print("DID RECEIVE AD.")
    }

    func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
      print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
    }
  }
}

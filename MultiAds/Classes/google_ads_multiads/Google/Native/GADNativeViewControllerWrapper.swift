//
//  GADNativeViewWrapper.swift
//  AdmobNativeSample
//
//  Created by Sakura on 2021/05/07.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
public struct GADNativeViewControllerWrapper : UIViewControllerRepresentable {

    public func makeUIViewController(context: Context) -> UIViewController {
    let viewController = GADNativeViewController()
    return viewController
  }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }

}



@available(iOS 13.0, *)
public struct GoogleNativeAd : View{
    
    public  var height:CGFloat
    public   var width:CGFloat
    public   var from:String?
    
    
    
    
    @State public var adLoader = false
    @State public var config:AdConfigDataModel?
    public init(height: CGFloat, width: CGFloat,from:String?) {
        self.height = height
        self.width = width
        self.from = from ?? "default"
    }
    
    public func configration() {
        self.adLoader = true
        if(self.from != nil){
            let defaultConfig:AdConfigDataModel? = ServerConfig.sharedInstance.screenConfig?["default"]
            print("fething from : \(self.from!)")
            let server:AdConfigDataModel? = ServerConfig.sharedInstance.screenConfig?[self.from!]
            
            print("fething server object : \(String(describing: server ?? nil))")
            print("fething default object : \(String(describing: defaultConfig ?? nil))")

            if(server != nil){
                self.config = server!
            }else{
                self.config = defaultConfig!

            }
            
           
        } else{
            self.config =  ServerConfig.sharedInstance.screenConfig?["default"]
            print("From is null - [Google Native]")
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
    

    @available(iOS 13.0, *)
    public var body: some View{
        let calPadding = min(width * 1.5 / 100, 10)
        Group {
            if(adLoader || config == nil){
                VStack {
                    Spacer()
                    Text("Ad Loading...")
                    Spacer()
                } .frame(width: 250,height: 250)
                    
            }else{
                VStack {
                    if(!ServerConfig.sharedInstance.globalAdStatus){
                        VStack {}
                            .frame(width: 0,height: 0)
                            .padding(.zero)
                    }else{
                        if(config!.showAds){
                            if(config!.native == 1){
                                GADNativeViewControllerWrapper()
                                    .frame(width:355,height: 402)
                                    .padding(10)
                            }else{
                                VStack {}
                                    .frame(width: 0,height: 0)
                                    .padding(.zero)
                            }
                           
                        }else{
                            VStack {}
                                .frame(width: 0,height: 0)
                                .padding(.zero)
                        }
                    }
                }
            }
        }
        .onAppear{
            configration()
        }
        
    }
}

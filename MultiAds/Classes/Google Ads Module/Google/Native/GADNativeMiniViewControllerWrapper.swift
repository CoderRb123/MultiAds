//
//  GADNativeMiniViewWrapper.swift
//  AdmobNativeSample
//
//  Created by Sakura on 2021/05/07.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
public struct GADNativeMiniViewControllerWrapper : UIViewControllerRepresentable {

    public func makeUIViewController(context: Context) -> UIViewController {
    let viewController = GADNativeMiniViewController()
    return viewController
  }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }

}



@available(iOS 13.0, *)
public struct GoogleNativeMiniAd : View{
    
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
            print("From is null - [Google Native Mini]")
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
                  
                } .frame(width: 0,height: 0)
                    
            }else{
                VStack {
                    if(!ServerConfig.sharedInstance.globalAdStatus){
                        VStack {}
                            .frame(width: 0,height: 0)
                            .padding(.zero)
                    }else{
                        if(config!.showAds){
                            GADNativeMiniViewControllerWrapper()
                                .frame(width:403,height: 101)
                           
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

//
//  SwiftUIView.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 01/02/25 For.
//

import SwiftUI

@available(iOS 14.0, *)
public struct AppAdHelper<Content: View>: View {
    
    let content: () -> Content
    @State var notFirstTime: Bool = false
    let registerAppParameters:RegisterAppParameters
    let onSdkInitialized: () -> Void
    @State private var showAlert = false

    
    public init(@ViewBuilder content: @escaping () -> Content,registerAppParameters: RegisterAppParameters,onSdkInitialized: @escaping () -> Void) {
        self.content = content
        self.registerAppParameters = registerAppParameters
        self.onSdkInitialized = onSdkInitialized
    }
    public var body: some View {
        VStack {
            content().onAppear {
                if(!notFirstTime){
                    MultiAdsManager().setUp(
                        registerAppParameters: RegisterAppParameters(     
                            appVersion:registerAppParameters.appVersion,
                            rewardType:registerAppParameters.rewardType,
                            apiKey: registerAppParameters.apiKey,
                            onUpdateLaunch: registerAppParameters.onUpdateLaunch,
                            onError: registerAppParameters.onError,
                            onComplete: { data in
                                notFirstTime = true
                                registerAppParameters.onComplete(data)
                            },
                           
                        ),
                        onSdkInitialized: onSdkInitialized
                    )
                }
            }
        
        }
    }
}



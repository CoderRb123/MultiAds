//
//  BannerWrapper.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 21/05/25.
//



import SwiftUI


@available(iOS 14.0, *)
public struct BannerWrapper<Content: View> : View {
    public let content: () -> Content

    public var from:String
    public init(from: String = "default",@ViewBuilder content: @escaping () -> Content) {
        self.from = from
        self.content = content
    }
    public var body: some View {
        ZStack {
            content()
            VStack {
               Spacer()
                AdEngine.shared.loadShowBanner(from: from)
            }.ignoresSafeArea()
        }
    }
}

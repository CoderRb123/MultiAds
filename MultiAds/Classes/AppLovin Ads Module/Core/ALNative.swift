import AppLovinSDK
import SwiftUI

@available(iOS 13.0, *)
struct AlNativeUIWrapper: UIViewRepresentable
{
  func makeUIView(context: Context) -> MAAdView
  {
      var placementId: String? = ServerConfig.sharedInstance.adNetworkIds?["applovin"]?.nativeId
    let adView = MAAdView(adUnitIdentifier: placementId ?? "", adFormat: MAAdFormat.mrec)
     adView.delegate = context.coordinator
     adView.backgroundColor = .clear
     adView.loadAd()

    return adView
  }

  func updateUIView(_ uiView: MAAdView, context: Context) {}

  func makeCoordinator() -> Coordinator
  {
    Coordinator()
  }
}

@available(iOS 13.0, *)
extension AlNativeUIWrapper
{
  class Coordinator: NSObject, MAAdViewAdDelegate
  {
    // MARK: MAAdDelegate Protocol

    func didLoad(_ ad: MAAd) {}

    func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {}

    func didClick(_ ad: MAAd) {}

    func didFail(toDisplay ad: MAAd, withError error: MAError) {}

    // MARK: MAAdViewAdDelegate Protocol

    func didExpand(_ ad: MAAd) {}

    func didCollapse(_ ad: MAAd) {}

    // MARK: Deprecated Callbacks

    func didDisplay(_ ad: MAAd) { /* use this for impression tracking */ }
    func didHide(_ ad: MAAd) { /* DO NOT USE - THIS IS RESERVED FOR FULLSCREEN ADS ONLY AND WILL BE REMOVED IN A FUTURE SDK RELEASE */ }
  }
}

// SwiftUI view to show ad
@available(iOS 13.0, *)
struct AlNativeView: View
{
  // MREC width and height are 300 and 250 respectively, on iPhone and iPad
    let height = 250.0
    let width = 300.0

  var body: some View {
      AlNativeUIWrapper()
          .frame(width: width, height: height)
  }
}

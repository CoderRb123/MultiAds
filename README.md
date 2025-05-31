# MultiAds

**MultiAds** is a custom in-house Swift plugin designed to seamlessly integrate and manage multiple ad networks under a unified interface. It simplifies the implementation of interstitial, rewarded, and banner ads for iOS apps by abstracting each ad SDK into a pluggable, scalable architecture.

## ✨ Features

- 🔌 Plug-and-play integration with major ad networks (e.g., AdMob, AppLovin, Unity, etc.)
- 🧠 Smart mediation logic with failover support
- 📊 Unified interface for loading, showing, and handling callbacks
- 🧩 Modular adapters with binary target support for custom SDKs
- 📱 SwiftUI and UIKit compatible

## 📦 Installation

Add `MultiAds` to your `Podfile`:

```ruby
pod 'MultiAds', :git => 'https://github.com/your-org/MultiAds.git', :tag => '1.0.0'
```

Then run:

```bash
pod install
```

Make sure to include the required adapter SDKs (AppLovin, Google Mobile Ads, etc.) in your project or via your own plugins.

## 🛠 Usage

### 1. Initialize MultiAds

```swift
MultiAdsManager.shared.initializeNetworks()
```

### 2. Load and Show Ads

```swift
MultiAdsManager.shared.loadAndShowInterstitial(from: viewController)
MultiAdsManager.shared.loadAndShowRewarded(from: viewController)
```

### 3. Native Ads (SwiftUI compatible)

```swift
MultiAdsManager.shared.getNativeAdView(height: 300, width: 350)
```

### 4. Ad Callbacks

You can subscribe to ad events using:

```swift
MultiAdsManager.shared.delegate = self
```

And conform to the relevant delegate protocols.

## 🧩 Supported Networks

- ✅ Google AdMob
- ✅ AppLovin
- ✅ Unity Ads
- 🛠 Custom network support via adapter interfaces

## 🔐 Requirements

- iOS 13.0+
- Swift 5.3+
- Xcode 14+

## 📁 Folder Structure

```
MultiAds/
├── Sources/
│   ├── AdManager.swift
│   ├── AdProtocols.swift
│   └── AdAdapters/
│       ├── AdMobAdapter.swift
│       └── AppLovinAdapter.swift
├── Resources/
│   └── XIBs, Localized Strings, etc.
```

## 🚧 Development & Contribution

This plugin is currently an internal tool and not open to public contribution. For bug reports or feature requests, please contact the RB Techlab team.

## 📄 License

This project is proprietary and maintained by [RB Techlab](https://rbtechlab.in). Unauthorized use is prohibited.

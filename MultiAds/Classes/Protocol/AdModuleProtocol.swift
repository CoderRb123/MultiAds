public class AdModuleWithCallBacks {
    public  var onCloseEvent: (() -> Void)?
    public var onFailed: (() -> Void)?
    public var onRewardSkip: (() -> Void)?
    public var onLoadFailed: (() -> Void)?
    public var onAdStarted: (() -> Void)?
    public var onAdLoaded: (() -> Void)?

    public init(onCloseEvent: (() -> Void)? = nil,
         onFailed: (() -> Void)? = nil,
         onAdLoaded: (() -> Void)? = nil,
         onAdStarted: (() -> Void)? = nil,
         onRewardSkip: (() -> Void)? = nil,
         onLoadFailed: (() -> Void)? = nil) {
        self.onCloseEvent = onCloseEvent
        self.onFailed = onFailed
        self.onAdLoaded = onAdLoaded
        self.onAdStarted = onAdStarted
        self.onRewardSkip = onRewardSkip
        self.onLoadFailed = onLoadFailed
    }

    public func copyWith(onCloseEvent: (() -> Void)? = nil,
                         onFailed: (() -> Void)? = nil,
                         onRewardSkip: (() -> Void)? = nil,
                         onLoadFailed: (() -> Void)? = nil,
                         onAdStarted: (() -> Void)? = nil,
                         onAdLoaded: (() -> Void)? = nil) -> AdModuleWithCallBacks {
        return AdModuleWithCallBacks(
                 onCloseEvent: onCloseEvent,
                 onFailed: onFailed,
                 onAdLoaded: onAdLoaded,
                 onAdStarted: onAdStarted,
                 onRewardSkip: onRewardSkip,
                 onLoadFailed: onLoadFailed)
    }
}

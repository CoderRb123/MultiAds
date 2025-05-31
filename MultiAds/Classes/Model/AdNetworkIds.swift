
import Foundation

public class AdNetworkIds {
    public let configId: String?
    public let interId: String?
    public let rewardId: String?
    public let interRewardId: String?
    public let nativeId: String?
    public let bannerId: String?

    public  init(configId: String?, interId: String?, rewardId: String?, interRewardId: String?, nativeId: String?, bannerId: String?) {
        self.configId = configId
        self.interId = interId
        self.rewardId = rewardId
        self.interRewardId = interRewardId
        self.nativeId = nativeId
        self.bannerId = bannerId
    }

    public static func fromJson(data: [String: Any]) -> AdNetworkIds {
        return AdNetworkIds(
            configId: data["configId"] as? String,
            interId: data["interId"] as? String,
            rewardId: data["rewardId"] as? String,
            interRewardId: data["interRewardId"] as? String,
            nativeId: data["nativeId"] as? String,
            bannerId: data["bannerId"] as? String
        )
    }
}


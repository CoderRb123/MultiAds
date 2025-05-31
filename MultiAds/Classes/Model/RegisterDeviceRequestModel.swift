//
//  RegisterDeviceRequestModel.swift
//  CommonInterface_ios
//
//  Created by Khusnud Zehra on 15/01/25.
//


struct RegisterDeviceRequestModel: Codable {
    

    let id: String?
    let deviceID: String?
    let deviceName: String?
    let deviceType: String?
    let deviceISP: String?
    let deviceOSVersion: String?
    let deviceIP: String?
    let deviceCountry: String?
    let deviceCity: String?
    let deviceLocation: String?
    let deviceZip: String?
    let deviceIIFD: String?
    let appName: String?
    let package: String?
    let version: String?
    let buildNumber: String?
    let appCount: Int?
    let devicePublicKey: String?
    let rewardTypeID: String?
    let createdAt: String?
    let updatedAt: String?
    
    

    enum CodingKeys: String, CodingKey {
        case id
        case deviceID = "device_id"
        case deviceName = "device_name"
        case deviceType = "device_type"
        case deviceISP = "device_isp"
        case deviceOSVersion = "device_os_version"
        case deviceIP = "device_ip"
        case deviceCountry = "device_country"
        case deviceCity = "device_city"
        case deviceLocation = "device_location"
        case deviceZip = "device_zip"
        case deviceIIFD = "device_iifd"
        case appName
        case package
        case version
        case buildNumber
        case appCount = "app-count"
        case devicePublicKey = "device_public_key"
        case rewardTypeID = "reward_type_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//
//  NetworkMonitor.swift
//  MultiAdsInterface
//
//  Created by Khusnud Zehra on 03/05/25.
//

import Foundation
import Network
import Combine

final class NetworkMonitor: ObservableObject {
    
    static var shared: NetworkMonitor = NetworkMonitor()
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")

    @Published var isConnected: Bool = false

    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: workerQueue)
    }

    deinit {
        networkMonitor.cancel()
    }
}

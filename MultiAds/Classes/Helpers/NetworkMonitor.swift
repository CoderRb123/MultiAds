import Foundation
import Network
import Combine

@available(iOS 14.0, *)
final class NetworkMonitor: ObservableObject {
    
    static var shared: NetworkMonitor = NetworkMonitor()
    
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected: Bool = false
    
    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard path.status == .satisfied else {
                DispatchQueue.main.async {
                    self?.isConnected = false
                }
                return
            }
            
            // Network available, now check actual internet access
            self?.checkInternetAccess()
        }
        networkMonitor.start(queue: workerQueue)
    }
    
    private func checkInternetAccess() {
        guard let url = URL(string: "https://www.apple.com/library/test/success.html") else { return }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5 // short timeout for responsiveness
        
        URLSession.shared.dataTask(with: request) { _, response, _ in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    self.isConnected = true
                } else {
                    self.isConnected = false
                }
            }
        }.resume()
    }

    deinit {
        networkMonitor.cancel()
    }
}

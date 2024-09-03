//
//  NetworkMonitor.swift
//  Poetry
//
//  Created by Agata Przykaza on 02/09/2024.
//

import Foundation
import Network
@Observable
class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}

//
//  PoetryApp.swift
//  Poetry
//
//  Created by Agata Przykaza on 14/08/2024.
//

import SwiftUI

@main
struct PoetryApp: App {
    
    @State var appModel: AppModel =  AppModel()
    @State var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(appModel)
                .environment(networkMonitor)
        }
    }
}

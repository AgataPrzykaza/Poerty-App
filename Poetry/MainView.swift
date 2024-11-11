//
//  MainView.swift
//  Poetry
//
//  Created by Agata Przykaza on 15/08/2024.
//

import SwiftUI

struct MainView: View {
    
    @State var selection: Int = 0
    @Environment(AppModel.self) private var appModel
    @Environment(NetworkMonitor.self) private var networkMonitor
    
    var body: some View {
        
        if networkMonitor.isConnected{
            
            TabView(selection: $selection) {
                
                // MAIN VIEW__________________
                NavigationStack(){
                    PoemListView()
                    
                    
                }
                .tabItem {
                    Text("Home view")
                    Image(systemName: "house.fill")
                        .renderingMode(.template)
                }
                .tag(0)
                //AUTHORS VIEW+_________________
                NavigationStack() {
                    AuthorsListView()
                    
                    
                }
                .tabItem {
                    Label("Authors", systemImage: "person.fill")
                }
                .tag(1)
                
                //SEARCH VIEW___________________
                NavigationStack() {
                    SearchView()
                    
                    
                }
                .tabItem {
                    Text("Search")
                    
                    Image(systemName: "magnifyingglass")
                    
                }
                .tag(2)
                
                //FAVOURUTES VIEW_________________
                NavigationStack() {
                    FavoritePoemView()
                    
                    
                    
                }
                .tabItem {
                    Text("Favourites")
                    Image(systemName: "heart")
                    
                }
                .tag(3)
            }
            .onAppear{
                appModel.fetchPoems()
                appModel.getFavorites()
            }
        }
        else{
            
           NetworkUnavailableView()
        }
        
        
        
    }
}




#Preview {
    MainView()
        .environment(AppModel())
        .environment(NetworkMonitor())
}

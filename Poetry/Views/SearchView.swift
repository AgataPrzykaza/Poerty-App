//
//  SearchView.swift
//  Poetry
//
//  Created by Agata Przykaza on 28/08/2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(NetworkMonitor.self) private var networkMonitor
    @State var searchText: String = ""
    
    @State var searchResult: [Poem] = []
    
    func fetchSearch(){
        
        appModel.api.fetchPoemsSearch(title: searchText) { result in
                switch result {
                case .success(let fetchedPoems):
                    self.searchResult = fetchedPoems
                case .failure(let error):
                    print("Error fetching poems: \(error)")
                }
            }
    }
    
    var body: some View {
        
        if networkMonitor.isConnected{
            
            VStack(alignment: .leading){
                
                Text("Search Poem")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                TextField("Search", text: $searchText)
                    .onSubmit {
                        searchResult = []
                        fetchSearch()
                    }
                    .frame(height: 50)
                    .background(.gray, in: RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                if !searchResult.isEmpty{
                    List{
                        
                        ForEach(searchResult){ poem in
                            VStack{
                                PoemCardView(poem: poem)
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    .listStyle(.plain)
                }
                else{
                    VStack(alignment: .center){
                        Text("Nothing yet found!")
                    }
                    .frame(maxWidth: .infinity)
                 
                }
            }
        }
        else
        {
            NetworkUnavailableView()
        }
        Spacer()
        
        
    }
}

#Preview {
    SearchView()
}

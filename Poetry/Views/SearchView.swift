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
                
                HStack{
                    TextField("Search", text: $searchText)
                        .onSubmit {
                            searchResult = []
                            fetchSearch()
                        }
                        .frame(height: 50)
                        .background(.gray.opacity(0.4), in: RoundedRectangle(cornerRadius: 10))
                        .padding()
                    
                    Button {
                        searchResult = []
                        fetchSearch()
                    } label: {
                        Text("Submit")
                            .padding()
                            .foregroundStyle(.white)
                            .background(.gray.opacity(searchText.isEmpty ? 0.2:1),in: .capsule)
                    }
                    .disabled(searchText.isEmpty)

                }
                
                if !searchResult.isEmpty{
                   
                    ScrollView{
                        VStack(alignment: .center){
                            ForEach(searchResult){ poem in
                                
                                NavigationLink {
                                    
                                    PoemView(poem: poem)
                                    
                                    
                                } label: {
                                    
                                    PoemCardView(poem: poem)
                                        .padding(.bottom)
                                        .tint(.black)
                                }
                                
                                
                                
                                
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                        
                   
                }
                else{
                    VStack(alignment: .center){
                        Text("Nothing yet found!")
                    }
                    .frame(maxWidth: .infinity)
                 
                }
            }
            .padding(.horizontal)
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

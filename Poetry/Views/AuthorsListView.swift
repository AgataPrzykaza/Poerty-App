//
//  AuthorsListView.swift
//  Poetry
//
//  Created by Agata Przykaza on 19/08/2024.
//

import SwiftUI


struct AuthorsListView: View {
    
    @Environment(AppModel.self) private var appModel
    @Environment(NetworkMonitor.self) private var networkMonitor
    
    @State var searchText: String = ""
    
    var filteredAuthors: [String] {
        guard !searchText.isEmpty else { return appModel.authors }
        return appModel.authors.filter { author in
               author.lowercased().contains(searchText.lowercased())
           }
       }
    
    var body: some View {
        
       
            
            NavigationStack{
                if networkMonitor.isConnected{
                
                
                if !appModel.authors.isEmpty{
                    
                    List{
                        ForEach(filteredAuthors, id: \.self){ author in
                            
                            NavigationLink {
                                
                                AuthorsPoemsView(author: author)
                                
                                
                            } label: {
                                
                                HStack{
                                    Text(author)
                                        .font(.title3)
                                    Spacer()
                                }
                                .padding()
                            }
                            
                        }
                    }
                    .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
                    
                    
                    
                    
                    
                    
                    
                }
                else{
                        ProgressView()
                }
            }
            else{
                NetworkUnavailableView()
            }
            
            }
            .navigationTitle("Authors")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                appModel.fetchAuthors()
            }
       
       
    }
}



#Preview {
    AuthorsListView()
}

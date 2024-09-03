//
//  FavoritePoemView.swift
//  Poetry
//
//  Created by Agata Przykaza on 19/08/2024.
//

import SwiftUI

struct FavoritePoemView: View {
    
    @Environment(AppModel.self) private var appModel
    
     
    var body: some View {
        NavigationStack{
            
        

            
            ScrollView{
                LazyVStack {
                    
                    if !appModel.favorites.isEmpty{
                        ForEach(appModel.favorites){ poem in
                            PoemCardView(poem: poem)
                            
                        }
                    }
                    else{
                       
                        
                        ContentUnavailableView(
                            "No favorites",
                            systemImage: "heart",
                            description: Text("Add poeam that you like")
                            
                        )
                        
                        
                        
                    }
                    

                    
                    
                }
            }
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Favorite")
                    .bold()
                    .font(.largeTitle)
            }
            
            
        }
        .onAppear{
           
        }
    }
}

#Preview {
    FavoritePoemView()
}

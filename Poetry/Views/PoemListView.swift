//
//  ContentView.swift
//  Poetry
//
//  Created by Agata Przykaza on 14/08/2024.
//

import SwiftUI


struct PoemListView: View {
    
    @Environment(AppModel.self) private var appModel
    
    
    
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                LazyVStack {
                    
                    if !appModel.randomTodaysPoems.isEmpty{
                        ForEach(appModel.randomTodaysPoems){ poem in
                            
                            NavigationLink {
                                
                                
                                PoemView(poem: poem)
                                    .padding()
                                
                                
                            } label: {
                                PoemCardView(poem: poem)
                                    .padding(.bottom,20)
                                    .tint(.black)
                            }
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
            }
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Today's Poems")
                    .bold()
                    .font(.largeTitle)
            }
            
            
        }
      
        
       
    }
}

#Preview {
    PoemListView()
        .environment(AppModel())
}

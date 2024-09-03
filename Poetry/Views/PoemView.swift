//
//  PoemView.swift
//  Poetry
//
//  Created by Agata Przykaza on 14/08/2024.
//

import SwiftUI

struct PoemView: View {
    
    @State var liked: Bool = false
    
    @Environment(AppModel.self) private var appModel

    
    var poem: Poem
    
    var body: some View {
        ScrollView{
            
            
            LazyVStack(alignment: .leading){
                
              
                Text(poem.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                
                Text(poem.author)
                    .font(.subheadline)
                    .padding(.bottom,15)
                
                
                VStack(alignment: .leading){
                    ForEach(poem.lines, id: \.self){ line in
                        
                        Text(line)
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                        
                        
                    }
                }
                .frame(width: 325)
                
                Spacer()
            }
        }
        .frame(width: 325)
        .navigationTitle(poem.title)
        .onAppear{
            if appModel.favorites.contains(poem)
            {
                liked = true
            }
        }
        .toolbar{
            
            ToolbarItem{
                Button {
                    
                    liked.toggle()
                   
                    
                    if liked {
                        appModel.favorites.append(poem)
                        
                        appModel.saveFavorites()
                       
                        
                        
                    }
                    else{
                        
                        if let index = appModel.favorites.firstIndex(of: poem) {
                            appModel.favorites.remove(at: index)
                            appModel.saveFavorites()
                        }
                    }
                    
                    
                } label: {
                    Image(systemName: liked ? "heart.fill" : "heart")
                        .font(.headline)
                }
            }
        }
        
    }
}

#Preview {
    PoemView(poem: Poem(
        title: "The Road Not Taken",
        author: "Robert Frost",
        lines: [
            "Two roads diverged in a yellow woodsf",
            "And sorry I could not travel both  ",
            "And be one traveler, long I stoodsd fsdfsdf ",
            "And looked down one as far as I could",
            "To where it bent in the undergrowth;"
        ],
        linecount: "5"
    ))
}

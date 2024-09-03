//
//  PoemCardView.swift
//  Poetry
//
//  Created by Agata Przykaza on 14/08/2024.
//

import SwiftUI

struct PoemCardView: View {
    
    var poem: Poem
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading){
               
                Text(poem.title)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.leading)
                    
                
                Text(poem.author)
                    .padding(.bottom,15)
               
                Text(poem.lines.first!)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom,20)
                  
             
                Image(systemName: "ellipsis")
                    .padding(.leading,150)
                    .bold()
                    .font(.title)
                
               Spacer()
                
                
            }
            .padding()
            
           
            
            Spacer()
        }
        .frame(width: 350,height: 150)
        .background(Color.red.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
       
    }
}

#Preview {
    PoemCardView(poem: Poem(
        title: "The Road Not Taken my word for you innoe every",
        author: "Robert Frost",
        lines: [
            "Two roads diverged in a yellow woodsf dfs sdf",
            "And sorry I could not travel both  ",
            "And be one traveler, long I stoodsd fsdfsdf ",
            "And looked down one as far as I could",
            "To where it bent in the undergrowth;"
        ],
        linecount: "5"
    ))
}

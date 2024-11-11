//
//  AuthorsPoemsView.swift
//  Poetry
//
//  Created by Agata Przykaza on 19/08/2024.
//

import SwiftUI

struct AuthorsPoemsView: View {
    
    @Environment(AppModel.self) private var appModel
    var author: String
    @State var poemsArray: [Poem] = []
    @State var authorWiki: WikipediaSummary?
    
    func shortenSummary() -> String{
        
        guard let extract = authorWiki?.extract else {
            
            return "No summary available."
        }
        
        let sentences = extract.components(separatedBy: ". ")
        let selectedSentences = sentences.prefix(2)
        let result = selectedSentences.joined(separator: ". ")
        return result + (result.last == "." ? "" : ".")
        
    }
    
    
    
    func fetchWiki(){
        appModel.api.fetchAuthorSummary(author: author) { result in
            switch result {
            case .success(let summary):
                authorWiki = summary
            case .failure(let error):
                print("Error fetching summary: \(error)")
            }
        }
    }
    
    func fetchAuthorsPoems(){
        appModel.api.fetchPoemsForAuthor(author: author) { result in
            switch result {
            case .success(let poems):
                poemsArray = poems
            case .failure(let error):
                print("Error fetching poems: \(error)")
            }
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            authorHeader
            
            ScrollView{
                VStack{
                    
                    Text(shortenSummary())
                        .padding(.bottom,10)
                        .frame(height: 100)
                    
                    
                    
                    if !poemsArray.isEmpty{
                        ForEach(poemsArray){ poem in
                            
                            NavigationLink {
                                
                                PoemView(poem: poem)
                                
                                
                            } label: {
                                
                                PoemCardView(poem: poem)
                                    .tint(.black)
                            }
                            
                            
                        }
                        
                    }
                }
            }
            
            
            Spacer()
        }
        .padding(.horizontal,25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear{
            fetchWiki()
            fetchAuthorsPoems()
            
        }
    }
}

extension AuthorsPoemsView {
    var authorHeader: some View{
        HStack{
            Text(author)
                .font(.title)
                .padding(.bottom,10)
            
            Spacer()
            
            if let url = authorWiki?.thumbnail?.source{
                AsyncImage(url:  URL(string: url) ) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .clipped()
                    
                } placeholder: {
                    ProgressView()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 80, height: 80)
                }

            }
            else {
                
                Image("blankPerson")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    
                    
            }
           
           

            
            
        }
        .padding(.bottom,10)
    }
}



#Preview {
    AuthorsPoemsView(author: "Emily Dickson")
}

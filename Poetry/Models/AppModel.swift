//
//  AppModel.swift
//  Poetry
//
//  Created by Agata Przykaza on 15/08/2024.
//

import Foundation
import SwiftUI


struct AuthorsList: Codable {
    let authors: [String]
}

@Observable class AppModel{
    
    var randomTodaysPoems: [Poem] = []
    var authors: [String] = []
    var api: APIController = APIController()
   
    var favorites: [Poem] = []
   
    
    func saveFavorites() {
        
         var allPoems: [String] = []
        
        for poem in favorites{
            
            allPoems.append(poem.id)
            
        }
        
        UserDefaults.standard.set(allPoems, forKey: "favoritePoems")
    }
    
    
    
    func getFavorites(){
        
        if let savedPoems = UserDefaults.standard.array(forKey: "favoritePoems") as? [String] {
           
            for poemInfo in savedPoems{
                
                let components = poemInfo.split(separator: "|")
                           if components.count == 2 {
                               let title = String(components[0])
                               let author = String(components[1])
                               
                               // fetch poem and save to favorites here
                               
                               api.fetchPoemFromTitleAuthor(author: author, title: title) { result in
                                       switch result {
                                       case .success(let fetchedPoems):
                                           self.favorites.append(fetchedPoems.first!)
                                       case .failure(let error):
                                           print("Error fetching poem for title and author: \(error)")
                                       }
                                   }
                               
                           }
                
                
            }
            
            
        }

        
        
    }
    
    func fetchPoems(){
        api.fetchAllPoems { result in
                switch result {
                case .success(let fetchedPoems):
                    self.randomTodaysPoems = fetchedPoems
                case .failure(let error):
                    print("Error fetching poems: \(error)")
                }
            }
    }
    
    func fetchAuthors(){
        api.fetchAuthors { result in
            switch result {
            case .success(let fetchedAuthors):
                self.authors = fetchedAuthors
            case .failure(let error):
                print("Error fetching authors: \(error)")
            }
        }
    }
    
}

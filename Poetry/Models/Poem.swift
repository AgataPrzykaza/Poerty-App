//
//  Poem.swift
//  Poetry
//
//  Created by Agata Przykaza on 14/08/2024.
//

import Foundation

struct Poem: Codable, Identifiable, Equatable {
    let title: String
    let author: String
    let lines: [String]
    let linecount: String
    
   
    var id: String { title + "|" + author }
}

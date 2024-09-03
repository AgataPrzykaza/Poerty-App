//
//  WikipediaSummary.swift
//  Poetry
//
//  Created by Agata Przykaza on 20/08/2024.
//

import Foundation

struct WikipediaSummary: Codable {
    let title: String
    let extract: String
    let thumbnail: Thumbnail?
    
    struct Thumbnail: Codable {
        let source: String
        let width: Int
        let height: Int
    }
}

//
//  APIController.swift
//  Poetry
//
//  Created by Agata Przykaza on 14/08/2024.
//

import Foundation

class APIController {
    
    
    func fetchPoemFromTitleAuthor(author: String,title: String,completion: @escaping (Result<[Poem], Error>) -> Void){
        // Kodowanie parametrów w URL
            let encodedAuthor = author.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            // Budowanie URL zgodnie z formatem API
           
        guard let url = URL(string: "https://poetrydb.org/title,author/\(encodedTitle):abs;\(encodedAuthor)") else {
            completion(.failure(URLError(.badURL)))
               return
           }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            if let data = data {
                
                
                do {
                    let decodedData = try JSONDecoder().decode([Poem].self, from: data)
                    
                    DispatchQueue.main.async{
                        completion(.success(decodedData))
                    }
                    
                } catch{
                    completion(.failure(error))
                }
            }
            
        }
        .resume()
        
    }
    
   
     

    
    func fetchAuthorSummary(author: String,completion: @escaping(Result<WikipediaSummary,Error>) -> Void){
        
        let encodedAuthor = author.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        
        guard let url = URL(string: "https://en.wikipedia.org/api/rest_v1/page/summary/\(encodedAuthor)") else{
            
            completion(.failure(URLError(.badURL)))
            return
            
        }
        
        
        URLSession.shared.dataTask(with: url){data,response,error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            if let data = data {
               
                    do {
                        
                        let decodedData = try JSONDecoder().decode(WikipediaSummary.self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                
            }
            
        }.resume()
        
    }
    
    
    func fetchPoemsSearch(title: String,completion: @escaping(Result<[Poem],Error>) -> Void){
        
        
       
            let encodedAuthor = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            guard let url = URL(string: "https://poetrydb.org/title/\(encodedAuthor)/title,author,lines,linecount") else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                if let data = data {
                    do {
                        
                        let decodedData = try JSONDecoder().decode([Poem].self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
                
            }.resume()
        
    }
    
    func fetchPoemsForAuthor(author: String,completion: @escaping(Result<[Poem],Error>) -> Void){
        
        
        // Kodowanie imienia i nazwiska autora
            let encodedAuthor = author.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            guard let url = URL(string: "https://poetrydb.org/author/\(encodedAuthor)") else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                
                if let data = data {
                    do {
                        
                        let decodedData = try JSONDecoder().decode([Poem].self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
                
            }.resume()
        
    }
    
    func fetchAuthors(completion: @escaping (Result<[String], Error>) -> Void){
        
        guard let url = URL(string: "https://poetrydb.org/author") else{
            completion(.failure(URLError(.badURL)))
            return
        }
        
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(AuthorsList.self, from: data)
                    
                    DispatchQueue.main.async{
                        completion(.success(decodedData.authors))
                    }
                    
                } catch{
                    completion(.failure(error))
                }
            }
            
        }
        .resume()
        
    }
    
    func fetchAllPoems(completion: @escaping (Result<[Poem], Error>) -> Void){
        // 1. Tworzenie URL
        guard let url = URL(string: "https://poetrydb.org/random/10") else {
            completion(.failure(URLError(.badURL)))
               return
           }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            if let data = data {
                
                
                do {
                    let decodedData = try JSONDecoder().decode([Poem].self, from: data)
                    
                    DispatchQueue.main.async{
                        completion(.success(decodedData))
                    }
                    
                } catch{
                    completion(.failure(error))
                }
            }
            
        }
        .resume()
        
    }
}

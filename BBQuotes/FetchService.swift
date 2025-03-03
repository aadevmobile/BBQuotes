//
//  FetchService.swift
//  bbquotes
//
//  Created by Anie on 3/1/25.
//

import Foundation

struct FetchService {
   private enum FetchError: Error {
        case badResponse
    }
    
    private let baseURL: URL = URL (string: "https://breaking-bad-api-six.vercel.app/api")!
    
    //breaking-bad-api-six.vercel.app/api/quotes/random?production=[show]
    func fetchQuote(from show: String) async throws -> Quote {
        // build fetch URL
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem (name: "production", value: show)])
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
            }
        // decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        // return data
        return quote
    }
    
    //breaking-bad-api-six.vercel.app/api/characters?name=[name]
    func fetchCharacter( _ name: String) async throws -> Char {
        // build fetch URL
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem (name: "name", value: name)])
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
            }
        // decode data || with snakeCase adjustment
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let characters = try decoder.decode([Char].self, from: data)
        // return data
        return characters[0]
        
    }
    
    //breaking-bad-api-six.vercel.app/api/deaths
    func fertchDeath (for character: String) async throws -> Death? {
        // build fetch URL
        let fetchURL = baseURL.appending(path: "deaths")
        // fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        // handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
            }
        // decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        return nil
    }
}




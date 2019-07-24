//
//  Networking.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 24/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation


struct rates: Decodable {
    
    let date: String
    
    let base: String
    
    let rates: [String: Double]
}

enum NetworkError: Error {
    
    case invalidUrl
    
    case requestFailed
    
    case decodingFailed
}

let stringUrl = "https://api.exchangeratesapi.io/latest"

func getRatesFor(base: String?, currencies: [String]?, completion: @escaping(Result<rates, NetworkError>) -> Void) {
    
    let base = base ?? "EUR"
    
    var components = URLComponents(string: stringUrl)
    
    let baseQuery = URLQueryItem(name: "base", value: base)
    
    if let currencies = currencies {
        
        let symbolQuery = URLQueryItem(name: "symbols", value: currencies.joined(separator: ","))
        
        components?.queryItems = [baseQuery, symbolQuery]
    }
    else {
        
        components?.queryItems = [baseQuery]
    }
    
    guard let absoluteString = components?.string, let url = URL(string: absoluteString) else { completion(.failure(.invalidUrl)); return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        guard error == nil, let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200, let data = data else { completion(.failure(.requestFailed)); return }
        
        do {
            
            let exchangeRates = try JSONDecoder().decode(rates.self, from: data)
            
            completion(.success(exchangeRates))
        }
        catch { completion(.failure(.decodingFailed)) }
        
        }.resume()
}


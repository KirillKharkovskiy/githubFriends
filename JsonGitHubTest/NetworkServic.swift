//
//  NetworServic.swift
//  JsonGitHubTest
//
//  Created by Кирилл on 18.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

class NetworkServic {
    
    func request(urlString: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let users = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(users))
                }catch let jsonError{
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

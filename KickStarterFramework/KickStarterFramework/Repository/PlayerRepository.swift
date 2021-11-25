//
//  PlayerRepository.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/11/16.
//

import Foundation

public final class PlayerRepository: PlayerRepositable {
    public init() {}
    
    public func fetchPlayerData(method: HTTPMethod, endpoint: String, completionHandler: @escaping PlayerRepositoryResultBlock ) {
        let urlString = endpoint
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue(Constants.APIKey, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            guard let data = data else { return }
            
            do {
                let decodedPlayerData = try JSONDecoder().decode(PlayerResponseModel.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(decodedPlayerData))
                }
                
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
            
        }.resume()
    }
}

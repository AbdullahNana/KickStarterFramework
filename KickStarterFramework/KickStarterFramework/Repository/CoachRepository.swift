//
//  CoachRepository.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/11/16.
//

import Foundation

public final class CoachRepository: CoachRepositable {
    public init() {}
    
    public func fetchCoachData(method: HTTPMethod, endpoint: String, completionHandler: @escaping CoachRepositoryResultBlock ) {
        let urlString = endpoint
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue(Constants.APIKey, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            guard let data = data else { return }
            
            do {
                let decodedCoachData = try JSONDecoder().decode(CoachResponseModel.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(decodedCoachData))
                }
                
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
            
        }.resume()
    }
}

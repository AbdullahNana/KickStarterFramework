//
//  TeamRepository.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/05.
//

import Foundation

public final class TeamRepository: TeamRepositable {
    public init() {}
    
    public func fetchTeamData(method: HTTPMethod, endpoint: String, completionHandler: @escaping TeamRepositoryResultBlock ) {
        let urlString = endpoint
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue(Constants.APIKey, forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            guard let data = data else { return }
            
            do {
                let decodedTeamData = try JSONDecoder().decode(SoccerTeamResponseModel.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(decodedTeamData))
                }
                
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
            
        }.resume()
    }
}

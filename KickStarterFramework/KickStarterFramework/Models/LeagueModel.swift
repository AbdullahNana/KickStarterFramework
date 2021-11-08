//
//  LeagueModel.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/19.
//

import Foundation

public struct LeagueModel: Codable {
    public init(league: League) {
        self.league = league
    }
    
    public let league: League
}

public struct League: Codable {
    public init(leagueID: String, leagueName: String, imageURL: String) {
        self.leagueID = leagueID
        self.leagueName = leagueName
        self.imageURL = imageURL
    }
    
    public let leagueID: String
    public let leagueName: String
    public let imageURL: String
    
    public enum CodingKeys: String, CodingKey {
        case leagueID = "leagueId"
        case leagueName, imageURL
    }
}

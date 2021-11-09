//
//  Endpoints.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/05.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
}

public enum ApiEndpoint: String {
    case teamData = "https://v3.football.api-sports.io/teams?league=39&season=2020"
    case liveScores = "https://www.livescore.com/en/"
}

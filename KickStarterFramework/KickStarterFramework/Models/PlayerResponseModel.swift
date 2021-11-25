//
//  PlayerResponseModel.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/11/16.
//

import Foundation

public struct PlayerResponseModel: Decodable {
    public init(get: String, response: [PlayerResponse]) {
        self.get = get
        self.response = response
    }
    
    public let get: String
    public let response: [PlayerResponse]
}

public struct PlayerResponse: Decodable {
    public  init(team: Teams, players: [Player]) {
        self.team = team
        self.players = players
    }
    
    public let team: Teams
    public let players: [Player]
}

public struct Player: Decodable {
    public init(id: Int, name: String, age: Int, number: Int?, position: String, photo: String) {
        self.id = id
        self.name = name
        self.age = age
        self.number = number
        self.position = position
        self.photo = photo
    }
    
    public let id: Int
    public let name: String
    public let age: Int
    public let number: Int?
    public let position: String
    public let photo: String
}

public struct Teams: Decodable {
    public init(id: Int, name: String, logo: String) {
        self.id = id
        self.name = name
        self.logo = logo
    }
    
    public let id: Int
    public let name: String
    public let logo: String
}

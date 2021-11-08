//
//  TeamData.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/04.
//

import Foundation

public struct Team: Codable {
    public init(id: Int?, name: String?, country: String?, founded: Int?, logo: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.founded = founded
        self.logo = logo
    }
    
    public let id: Int?
    public let name: String?
    public let country: String?
    public let founded: Int?
    public let logo: String?
}

@objcMembers public class Venue: NSObject, Codable {
    public init(id: Int?, name: String?, city: String?, capacity: Int? = nil, image: String?) {
        self.id = id
        self.name = name
        self.city = city
        self.capacity = capacity
        self.image = image
    }
    
    public let id: Int?
    public let name: String?
    public let city: String?
    public var capacity: Int?
    public let image: String?
    
    public var cap: NSNumber? {
        get {
            return capacity as NSNumber?
        }
        set(newNumber) {
            capacity = newNumber?.intValue
        }
    }
}

public struct Response: Codable {
    public init(team: Team, venue: Venue) {
        self.team = team
        self.venue = venue
    }
    
    public let team: Team
    public let venue: Venue
}

public struct SoccerTeamResponseModel: Codable {
    public init(get: String, response: [Response]) {
        self.get = get
        self.response = response
    }
    
    public let get: String
    public let response: [Response]
}

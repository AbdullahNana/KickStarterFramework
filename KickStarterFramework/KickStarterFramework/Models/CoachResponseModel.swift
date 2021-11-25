//
//  CoachResponseModel.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/11/16.
//

import Foundation

public struct CoachResponseModel: Decodable {
    public init(get: String, response: [Coach]) {
        self.get = get
        self.response = response
    }
    
    public let get: String
    public let response: [Coach]
}

public struct Coach: Decodable {
    public init(id: Int?, name: String?, firstname: String?, lastname: String?, age: Int?, nationality: String?, photo: String?) {
        self.id = id
        self.name = name
        self.firstname = firstname
        self.lastname = lastname
        self.age = age
        self.nationality = nationality
        self.photo = photo
    }
    
    public let id: Int?
    public let name: String?
    public let firstname: String?
    public let lastname: String?
    public let age: Int?
    public let nationality: String?
    public let photo: String?
}

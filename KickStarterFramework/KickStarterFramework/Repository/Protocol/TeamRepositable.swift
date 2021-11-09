//
//  Repositable.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/06.
//

import Foundation

public typealias TeamRepositoryResultBlock = (Result<SoccerTeamResponseModel, Error>) -> Void

public protocol TeamRepositable {
    func fetchTeamData(method: HTTPMethod, endpoint: String, completionHandler: @escaping TeamRepositoryResultBlock)
}

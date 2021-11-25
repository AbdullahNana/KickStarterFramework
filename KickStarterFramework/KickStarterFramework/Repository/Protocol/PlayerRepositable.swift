//
//  PlayerRepositable.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/11/16.
//

import Foundation

public typealias PlayerRepositoryResultBlock = (Result<PlayerResponseModel, Error>) -> Void

public protocol PlayerRepositable {
    func fetchPlayerData(method: HTTPMethod, endpoint: String, completionHandler: @escaping PlayerRepositoryResultBlock)
}

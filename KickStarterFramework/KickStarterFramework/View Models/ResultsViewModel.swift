//
//  ResultsViewModelHelper.swift
//  DisplayTeamsFramework
//
//  Created by Abdullah Nana on 2021/11/04.
//

import Foundation

public class ResultsViewModel {
    public init() {}
    
    public func resultsURL(result: String) -> URL? {
        return Bundle.main.url(forResource: result, withExtension: "html")
    }
}

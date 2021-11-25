//
//  DisplayCoachesViewModel.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/11/16.
//

import Foundation

public final class DisplayCoachesViewModel {
    public private(set) var coachResponse: CoachResponseModel?
    public private(set) var selectedTeam: Team?
    private var caochRepository: CoachRepositable
    private weak var delegate: TeamViewModelDelegate?
    
    public init(repository: CoachRepositable, delegate: TeamViewModelDelegate) {
        self.caochRepository =  repository
        self.delegate = delegate
    }
    
    public func endpoint(team: String) -> String {
        "https://v3.football.api-sports.io/coachs?team=\(team)"
    }
    
    public func searchEndpoint(coach: String) -> String {
        "https://v3.football.api-sports.io/coachs?search=\(coach)"
    }
    
    public func fetchCoachData(endpoint: String) {
        caochRepository.fetchCoachData(method: .GET, endpoint: endpoint) { [weak self] result in
            switch result {
            case .success(let coach):
                self?.coachResponse = coach
                self?.delegate?.refreshViewContents()
                if coach.response.isEmpty {
                    self?.delegate?.showSearchError()
                }
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error)
            }
        }
    }
    
    public func coachData(at index: Int) -> Coach? {
        coachResponse?.response[safe: index]
    }
    
    public func setTeam(selectedTeam: Team) {
        self.selectedTeam = selectedTeam
    }
    
    public var numberOfCoachResults: Int {
        coachResponse?.response.count ?? 0
    }
}

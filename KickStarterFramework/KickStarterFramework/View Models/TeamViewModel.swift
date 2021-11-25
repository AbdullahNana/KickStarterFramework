//
//  TeamViewModel.swift
//  Kick-Starter
//
//  Created by Abdullah Nana on 2021/10/04.
//

import Foundation

public class TeamViewModel {
    public private(set) var teamResponse: SoccerTeamResponseModel?
    public private(set) var selectedVenue: Venue?
    public private(set) var selectedLeague: League?
    public private(set) var selectedTeam: Team?
    private var teamRepository: TeamRepositable
    private weak var delegate: TeamViewModelDelegate?
    
    public init(repository: TeamRepositable, delegate: TeamViewModelDelegate) {
        self.teamRepository =  repository
        self.delegate = delegate
    }
    
    public func endpoint(league: String = "39", season: String = "2020") -> String {
        "https://v3.football.api-sports.io/teams?league=\(league)&season=\(season)"
    }
    
    public func searchEndpoint(searchString: String) -> String {
        "https://v3.football.api-sports.io/teams?search=\(searchString)"
    }
    
    public func fetchTeamData(endpoint: String) {
        teamRepository.fetchTeamData(method: .GET, endpoint: endpoint) { [weak self] result in
            switch result {
            case .success(let team):
                self?.teamResponse = team
                self?.delegate?.refreshViewContents()
                if team.response.isEmpty {
                    self?.delegate?.showSearchError()
                }
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error)
            }
        }
    }
    
    public func set(league: League) {
        selectedLeague = league
    }
    
    public func teamData(at index: Int) -> Response? {
        teamResponse?.response[safe: index]
    }
    
    public func setSelectedVenue(index: Int) {
        selectedVenue = teamResponse?.response[safe: index]?.venue
    }
    
    public func setSelectedTeam(index: Int) {
        selectedTeam = teamResponse?.response[safe: index]?.team
    }
    
    public var numberOfTeamResults: Int {
        teamResponse?.response.count ?? 0
    }
}

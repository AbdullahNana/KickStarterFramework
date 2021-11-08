//
//  KickStarterFrameworkTests.swift
//  KickStarterFrameworkTests
//
//  Created by Abdullah Nana on 2021/11/08.
//

import XCTest
@testable import KickStarterFramework

class KickStarterFrameworkTests: XCTestCase {
    private var mockedTeamRepository: MockTeamRepository!
    private var viewModelUnderTest: TeamViewModel!
    private var mockedDelegate: MockDelegate!
    
    override func setUp() {
        mockedTeamRepository = MockTeamRepository()
        mockedDelegate = MockDelegate()
        viewModelUnderTest = TeamViewModel(repository: mockedTeamRepository, delegate: mockedDelegate)
    }
    private var mockedTeamData: SoccerTeamResponseModel {
        let mockedTeamData = Response(team: Team(id: 33, name: "Manchester United", country: "England",
                                                 founded: 1878,
                                                 logo: "https://media.api-sports.io/football/teams/33.png"),
                                      venue: Venue(id: 557, name: "Old Trafford", city: "Manchester",
                                                   capacity: 76212,
                                                   image: "https://media.api-sports.io/football/venues/556.png"))
        return SoccerTeamResponseModel(get: "teams", response: [mockedTeamData])
    }
    func testFetchTeamDataSuccess() {
        mockedTeamRepository.teamApiResponse = .success(mockedTeamData)
        viewModelUnderTest.fetchTeamData(endpoint: viewModelUnderTest.endpoint())
        XCTAssert(!(viewModelUnderTest.teamResponse?.response.isEmpty ?? true))
        XCTAssert(mockedDelegate.refreshCalled)
    }
    func testFetchTeamDataFailure() {
        viewModelUnderTest.fetchTeamData(endpoint: viewModelUnderTest.endpoint())
        XCTAssert(viewModelUnderTest.teamResponse?.response.isEmpty ?? true)
        XCTAssert(mockedDelegate.showErrorCalled)
    }
    func testNumberOfTeamDataResultsArrayReturnsCorrectValueAfterSuccess() {
        mockedTeamRepository.teamApiResponse = .success(mockedTeamData)
        viewModelUnderTest.fetchTeamData(endpoint: viewModelUnderTest.endpoint())
        XCTAssertEqual(1, viewModelUnderTest.numberOfTeamResults)
    }
    func testNumberOfTeamDataResultsArrayReturnsNilAfterFailure() {
        viewModelUnderTest.fetchTeamData(endpoint: viewModelUnderTest.endpoint())
        XCTAssertEqual(0, viewModelUnderTest.numberOfTeamResults)
    }
    func testNumberOfTeamDataResultsFunctionReturnsCorrectValueAfterSuccess() {
        mockedTeamRepository.teamApiResponse = .success(mockedTeamData)
        viewModelUnderTest.fetchTeamData(endpoint: viewModelUnderTest.endpoint())
        XCTAssertEqual(viewModelUnderTest.teamData(at: 0)?.team.name, "Manchester United")
    }
    func testNumberOfTeamDataResultsFunctionReturnsNilAfterFailure() {
        viewModelUnderTest.fetchTeamData(endpoint: viewModelUnderTest.endpoint())
        XCTAssertEqual(viewModelUnderTest.teamData(at: 0)?.team.name, nil)
    }
    final class MockDelegate: TeamViewModelDelegate {
        func showSearchError() {}
        var refreshCalled = false
        var showErrorCalled = false
        func refreshViewContents() {
            refreshCalled = true
        }
        func showErrorMessage(error: Error) {
            showErrorCalled = true
        }
    }
    final class MockTeamRepository: TeamRepositable {
        var teamApiResponse: Result<SoccerTeamResponseModel, Error> = .failure(URLError(.badServerResponse))
        func fetchTeamData(method: HTTPMethod, endpoint: String, completionHandler: @escaping TeamRepositoryResultBlock) {
            completionHandler(teamApiResponse)
        }
    }
}

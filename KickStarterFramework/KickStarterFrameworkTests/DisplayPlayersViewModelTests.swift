//
//  DisplayPlayersViewModelTests.swift
//  KickStarterFrameworkTests
//
//  Created by Abdullah Nana on 2021/11/25.
//

import XCTest
@testable import KickStarterFramework

class DisplayPlayersViewModelTests: XCTestCase {
    
    private var mockedPlayerRepository: MockPlayerRepository!
    private var viewModelUnderTest: DisplayPlayersViewModel!
    private var mockedDelegate: MockDelegate!
    override func setUp() {
        mockedPlayerRepository = MockPlayerRepository()
        mockedDelegate = MockDelegate()
        viewModelUnderTest = DisplayPlayersViewModel(repository: mockedPlayerRepository, delegate: mockedDelegate)
    }
    
    private var mockedPlayerData: PlayerResponseModel {
        let player = Player(id: 1, name: "Lionel Messi", age: 34, number: 10, position: "Forward", photo: "Messi Photo")
        let team = Teams(id: 1, name: "Manchester United", logo: "Man United Logo")
        let response = PlayerResponse(team: team, players: [player])
        return PlayerResponseModel(get: "player", response: [response])
    }
    func testFetchCoachDataSuccess() throws {
        mockedPlayerRepository.playerApiResponse = .success(mockedPlayerData)
        viewModelUnderTest.fetchPlayerData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssert(!(viewModelUnderTest.playerResponse?.response.isEmpty ?? true))
        XCTAssert(mockedDelegate.refreshCalled)
    }
    func testCoachDataFailure() {
        viewModelUnderTest.fetchPlayerData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssert(viewModelUnderTest.playerResponse?.response.isEmpty ?? true)
        XCTAssert(mockedDelegate.showErrorCalled)
    }
    func testNumberOfPlayerDataResultsArrayReturnsCorrectValueAfterSuccess() {
        mockedPlayerRepository.playerApiResponse = .success(mockedPlayerData)
        viewModelUnderTest.fetchPlayerData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(1, viewModelUnderTest.numberOfPlayerResults)
    }
    func testNumberOfPlayerDataResultsArrayReturnsNilAfterFailure() {
        viewModelUnderTest.fetchPlayerData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(0, viewModelUnderTest.numberOfPlayerResults)
    }
    func testNumberOfPlayerDataResultsFunctionReturnsCorrectValueAfterSuccess() {
        mockedPlayerRepository.playerApiResponse = .success(mockedPlayerData)
        viewModelUnderTest.fetchPlayerData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(viewModelUnderTest.playerData(at: 0)?.name, "Lionel Messi")
    }
    func testNumberOfPlayerDataResultsFunctionReturnsNilAfterFailure() {
        viewModelUnderTest.fetchPlayerData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(viewModelUnderTest.playerData(at: 0)?.name, nil)
    }
    final class MockDelegate: ViewModelDelegate {
        var refreshCalled = false
        var showErrorCalled = false
        func refreshViewContents() {
            refreshCalled = true
        }
        func showErrorMessage(error: Error) {
            showErrorCalled = true
        }
    }
    final class MockPlayerRepository: PlayerRepositable {
        func fetchPlayerData(method: HTTPMethod, endpoint: String, completionHandler: @escaping PlayerRepositoryResultBlock) {
            completionHandler(playerApiResponse)
        }
        
        var playerApiResponse: Result<PlayerResponseModel, Error> = .failure(URLError(.badServerResponse))
    }
}


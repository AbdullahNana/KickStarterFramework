//
//  CoachesViewModelTests.swift
//  Kick-StarterTests
//
//  Created by Abdullah Nana on 2021/11/24.

import XCTest
@testable import KickStarterFramework

class DisplayCoachesViewModelTests: XCTestCase {

    private var mockedCoachRepository: MockCoachRepository!
    private var viewModelUnderTest: DisplayCoachesViewModel!
    private var mockedDelegate: MockDelegate!
    override func setUp() {
        mockedCoachRepository = MockCoachRepository()
        mockedDelegate = MockDelegate()
        viewModelUnderTest = DisplayCoachesViewModel(repository: mockedCoachRepository, delegate: mockedDelegate)
    }

    private var mockedCoachData: CoachResponseModel {
        let coach = Coach(id: 1, name: "Jurgen Klopp", firstname: "Klopp",
                          lastname: "Klopp", age: 50, nationality: "German", photo: "Klopp Photo")
        return CoachResponseModel(get: "coaches", response: [coach])
    }
    func testFetchCoachDataSuccess() throws {
        mockedCoachRepository.coachApiResponse = .success(mockedCoachData)
        viewModelUnderTest.fetchCoachData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssert(!(viewModelUnderTest.coachResponse?.response.isEmpty ?? true))
        XCTAssert(mockedDelegate.refreshCalled)
    }
    func testCoachTeamDataFailure() {
        viewModelUnderTest.fetchCoachData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssert(viewModelUnderTest.coachResponse?.response.isEmpty ?? true)
        XCTAssert(mockedDelegate.showErrorCalled)
    }
    func testNumberOfCoachDataResultsArrayReturnsCorrectValueAfterSuccess() {
        mockedCoachRepository.coachApiResponse = .success(mockedCoachData)
        viewModelUnderTest.fetchCoachData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(1, viewModelUnderTest.numberOfCoachResults)
    }
    func testNumberOfCoachDataResultsArrayReturnsNilAfterFailure() {
        viewModelUnderTest.fetchCoachData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(0, viewModelUnderTest.numberOfCoachResults)
    }
    func testNumberOfCoachDataResultsFunctionReturnsCorrectValueAfterSuccess() {
        mockedCoachRepository.coachApiResponse = .success(mockedCoachData)
        viewModelUnderTest.fetchCoachData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(viewModelUnderTest.coachData(at: 0)?.name, "Jurgen Klopp")
    }
    func testNumberOfCoahcDataResultsFunctionReturnsNilAfterFailure() {
        viewModelUnderTest.fetchCoachData(endpoint: viewModelUnderTest.endpoint(team: "33"))
        XCTAssertEqual(viewModelUnderTest.coachData(at: 0)?.name, nil)
    }
    final class MockDelegate: TeamViewModelDelegate {
        var refreshCalled = false
        var showErrorCalled = false
        var showSearchErrorCalled = false
        func showSearchError() {
            showSearchErrorCalled = true
        }
        func refreshViewContents() {
            refreshCalled = true
        }
        func showErrorMessage(error: Error) {
            showErrorCalled = true
        }
    }
    final class MockCoachRepository: CoachRepositable {
        var coachApiResponse: Result<CoachResponseModel, Error> = .failure(URLError(.badServerResponse))
        func fetchCoachData(method: HTTPMethod, endpoint: String,
                            completionHandler: @escaping CoachRepositoryResultBlock) {
            completionHandler(coachApiResponse)
        }
    }

}

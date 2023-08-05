//
//  CleanCodeTests.swift
//  CleanCodeTests
//
//  Created by abdul karim on 29/07/23.
//

import XCTest
@testable import CleanCode

final class CleanCodeTests: XCTestCase {
    
    var userListViewModel:UserListViewModel!
    var mockAPIService:MockAPIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIService = MockAPIService()
        userListViewModel = UserListViewModel(apoi)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        userListViewModel = nil
    }
    
    func testDecoding() throws {
        //arrange
        let json = """
         {
             "userId": 1,
             "id": 1001,
             "title": "Sample Title",
             "body": "This is a sample body"
         }
         """.data(using: .utf8)!
        
        //act
        let decoder = JSONDecoder()
        let userList = try decoder.decode(UserList.self, from: json)
        
        //add mock
        userListViewModel?.userList = [userList]
        
        //assert
        XCTAssertEqual(userList.userId, 1)
        XCTAssertEqual(userList.id, 1001)
        XCTAssertEqual(userList.title, "Sample Title")
        XCTAssertEqual(userList.body, "This is a sample body")
    }

    // any one either testInitialState or testNumberOfPosts
    func testNumberOfPosts(){
        XCTAssertEqual(userListViewModel?.noOfList(), userListViewModel?.userList.count, "Number of posts should be zero initially.")
    }
    
    func testItemAtIndex() {
        let itemAtIndex = userListViewModel?.postAtIndex(1)
        
        XCTAssertEqual(itemAtIndex?.userId, 2)
        XCTAssertEqual(itemAtIndex?.id, 1002)
    }
    
    
  
    /*
    func testFetchList_Success() async {
        let mockDelegate = MockUserListViewModelDelegate()
        userListViewModel?.viewModelDelegate = mockDelegate
        
        userListViewModel?.fetchList()
        XCTAssertTrue(mockDelegate.didFetchListSuccessfullyCalled)
    }
    
    func testFetchList_Loading() async {
        let mockDeleagte = MockUserListViewModelDelegate()
        userListViewModel?.viewModelDelegate = mockDeleagte
        
        userListViewModel?.fetchList()
        XCTAssertTrue(mockDeleagte.showLoadingCalled)
    }
     */
    
    func addMockData() throws {
        let json = """
         [
           {
             "userId": 1,
             "id": 1001,
             "title": "Sample Title",
             "body": "This is a sample body"
           },
           {
             "userId": 2,
             "id": 1002,
             "title": "Sample Title 2",
             "body": "This is a sample body 2"
           }
         ]
         """.data(using: .utf8)!
        
        //act
        let decoder = JSONDecoder()
        let userList = try decoder.decode([UserList].self, from: json)
        
        //add mock
        userListViewModel?.userList = userList
    }

}

// implement 1
class MockAPIService: APIService {
    var items: [UserList] = []
    var shouldThrowError = false

     func fetchItems() async throws -> [UserList] {
        if shouldThrowError {
            throw NSError(domain: "MockAPIService", code: 1, userInfo: nil)
        } else {
            return items
        }
    }
}


// implement 2
class MockUserListViewModelDelegate: UserListViewModelDelegate {
    var showLoadingCalled = false
    var didFetchListSuccessfullyCalled = false
    var didEncounterError: String?
    
    func userListViewModel(_ viewModel: UserListViewModel, showLoading: Bool) {
        showLoadingCalled = showLoading
    }
    
    func userListViewModel(_ viewModel: UserListViewModel, didFetchListSuccessfully: Bool) {
        didFetchListSuccessfullyCalled = didFetchListSuccessfully
    }
    
    func userListViewModel(_ viewModel: UserListViewModel, didEncounterError: String) {
        self.didEncounterError = didEncounterError
    }
}

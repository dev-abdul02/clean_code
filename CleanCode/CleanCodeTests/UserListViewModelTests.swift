//
//  CleanCodeTests.swift
//  CleanCodeTests
//
//  Created by abdul karim on 29/07/23.
//

import XCTest
@testable import CleanCode

final class UserListViewModelTests: XCTestCase {
    
    var viewModel:UserListViewModel!
    var mockAPIService:MockAPIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockAPIService = MockAPIService()
        viewModel = UserListViewModel(apiService: mockAPIService)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockAPIService = nil
        try super.tearDownWithError()
    }
    

    
    func testCallFetchPostAPI_Success() async {
        //given
        let expectedUserList = [
        UserList(userId: 1, id: 1, title: "Post 1", body: "Body 1"),
        UserList(userId: 1, id: 2, title: "Post 2", body: "Body 2")
        ]
        
        mockAPIService.responseData = try! JSONEncoder().encode(expectedUserList)
        
        //when
         await viewModel.callFetchPostAPI()
        
        //then
        XCTAssertEqual(viewModel.noOfList(), expectedUserList.count)
        XCTAssertEqual(viewModel.postAtIndex(0), expectedUserList[0])
        XCTAssertEqual(viewModel.postAtIndex(1), expectedUserList[1])
        
    }


    func testCallFetchPostAPI_Failure() async {
        mockAPIService.shouldThrowError = true
        
        await viewModel.callFetchPostAPI()
        
        XCTAssertTrue(viewModel.userList.isEmpty)
    }
    
    /*
     TODO - Unittest for state
     */

}

class MockAPIService:APIService {
    var responseData: Data?
    var shouldThrowError = false
    
    override func fetchPost(router: APIRouter) async throws -> Data {
        if shouldThrowError {
            throw NSError(domain: "MockAPIServce", code: 1)
        }
        else {
            return responseData ?? Data()
        }
    }
}


/*
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
     viewModel?.userList = [userList]
     
     //assert
     XCTAssertEqual(userList.userId, 1)
     XCTAssertEqual(userList.id, 1001)
     XCTAssertEqual(userList.title, "Sample Title")
     XCTAssertEqual(userList.body, "This is a sample body")
 }
 
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
     viewModel?.userList = userList
 }
 */

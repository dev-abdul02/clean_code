//
//  ViewModel.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import Foundation


class UserListViewModel {

    var userList: [UserList] = []
    private let apiService = APIService()
    
    func callFetchPostAPI() async {
        do {
            let data = try await apiService.fetchPost(router: .fetchPost)
            let decoder = JSONDecoder()
            let listObjs = try decoder.decode([UserList].self, from: data)
            self.userList = listObjs
        } catch {
            // Handle error appropriately
            print("Error fetching items: \(error)")
        }
    }
    
    func noOfList() -> Int {
        return userList.count
    }
    
    func postAtIndex(_ index:Int) -> UserList {
        return userList[index]
    }
}

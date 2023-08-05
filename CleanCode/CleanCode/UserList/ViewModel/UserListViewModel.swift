//
//  ViewModel.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import Foundation


class UserListViewModel {

    var userList: [UserList] = []
    private let apiService:APIService
    
    //state property
    enum UserListState {
        case loading
        case success
        case error(Error)
    }
    var stateDidChange: ((UserListState) -> Void)?
    
    var state: UserListState = .loading {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.stateDidChange?(self?.state ?? .loading)
            }
        }
    }
    
    
    init(apiService:APIService) {
        self.apiService = apiService
    }

    func callFetchPostAPI() async {
        state = .loading
        do {
            let data = try await apiService.fetchPost(router: .fetchPost)
            let decoder = JSONDecoder()
            let listObjs = try decoder.decode([UserList].self, from: data)
            self.userList = listObjs
            state = .success
        } catch {
            // Handle error appropriately
            print("Error fetching items: \(error)")
            state = .error(error)
        }
    }
    
    func noOfList() -> Int {
        return userList.count
    }
    
    func postAtIndex(_ index:Int) -> UserList {
        return userList[index]
    }
}

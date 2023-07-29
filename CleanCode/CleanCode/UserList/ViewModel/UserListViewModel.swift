//
//  ViewModel.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import Foundation

protocol UserListViewModelDelegate : AnyObject {
    func userListViewModel(_ viewModel:UserListViewModel, showLoading:Bool)
    func userListViewModel(_ viewModel:UserListViewModel, didFetchListSuccessfully:Bool)
    func userListViewModel(_ viewModel:UserListViewModel, didEncounterError:String)
}

class UserListViewModel {

    weak var viewModelDelegate:UserListViewModelDelegate?
    var userList:[UserList] = []
    
    
    func fetchList() {
        viewModelDelegate?.userListViewModel(self, showLoading: true)
        Task {
            do {
                self.userList = try await APIService.request(router: APIRouter.fetchLists)
                viewModelDelegate?.userListViewModel(self, didFetchListSuccessfully: true)
            } catch {
                viewModelDelegate?.userListViewModel(self, didEncounterError: error.localizedDescription)
            }
        }
    }
    
    func noOfList() -> Int {
        return userList.count
    }
    
    func postAtIndex(_ index:Int) -> UserList {
        return userList[index]
    }
}

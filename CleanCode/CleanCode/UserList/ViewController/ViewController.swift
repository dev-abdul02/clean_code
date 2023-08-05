//
//  ViewController.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tvTableView:UITableView! {
        didSet {
            tvTableView.delegate = self
            tvTableView.dataSource = self
            UserListTableViewCell.registerTableviewCellOn(tvTableView)
        }
    }
    
    private let viewModel = UserListViewModel(apiService: APIService())
    weak var mainCoordinator:MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        handleViewState()
        Task {
            await viewModel.callFetchPostAPI()
        }
    }
    
    func handleViewState() {
        viewModel.stateDidChange = { [weak self] state in
            switch state {
            case .loading:
                print("Loading..")
            case .success:
                self?.tvTableView.reloadData()
            case .error(let error):
                print("Handle error - \(error.localizedDescription)")
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let userListCell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.nibName) as? UserListTableViewCell {
            let userListObj = viewModel.postAtIndex(indexPath.row)
            userListCell.configureCell(data: userListObj)
            return userListCell
        }
            return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userListObj = viewModel.postAtIndex(indexPath.row)
        mainCoordinator?.showDetails(data: userListObj.title ?? "")
    }
}

extension ViewController : ViewFromNib {}


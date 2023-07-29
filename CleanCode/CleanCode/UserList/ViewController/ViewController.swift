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
    
    var viewModel = UserListViewModel()
    weak var mainCoordinator:MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewModelDelegate = self
        viewModel.fetchList()
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

extension ViewController : UserListViewModelDelegate {
    func userListViewModel(_ viewModel: UserListViewModel, showLoading: Bool) {
        debugPrint("show loading")
    }
    
    func userListViewModel(_ viewModel: UserListViewModel, didFetchListSuccessfully: Bool) {
        DispatchQueue.main.async {
            self.tvTableView.reloadData()
        }

    }
    
    func userListViewModel(_ viewModel: UserListViewModel, didEncounterError: String) {
        debugPrint("Error")
    }
}

extension ViewController : ViewFromNib {}


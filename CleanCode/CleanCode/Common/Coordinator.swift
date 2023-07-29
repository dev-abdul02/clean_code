//
//  Coordinator.swift
//  CleanCode
//
//  Created by abdul karim on 30/07/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    
    func startCoordinator()
}

class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    
    func startCoordinator() {
        let initialViewController = ViewController.instantiate()
        initialViewController.mainCoordinator = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(initialViewController, animated: false)
    }
    
    func showDetails(data:String) {
        let detailsViewController = DetailViewController()
        detailsViewController.data = data
        navigationController.pushViewController(detailsViewController, animated: false)
    }
}



protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

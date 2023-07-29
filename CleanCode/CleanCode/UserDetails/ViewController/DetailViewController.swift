//
//  DetailViewController.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var lDetailsLabel: UILabel!
    
    var data:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lDetailsLabel.text = data
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  UserListTableViewCell.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lTitleLable: UILabel!
    @IBOutlet weak var lSubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lTitleLable.numberOfLines = 0
        lSubtitleLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data:UserList) {
        lTitleLable.text = data.title ?? ""
        lSubtitleLabel.text = data.body ?? ""
    }
}

extension UserListTableViewCell : ViewFromNib {}

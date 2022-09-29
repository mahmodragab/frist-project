//
//  notificationCell.swift
//  frist-project
//
//  Created by abdallah ragab on 04/08/2022.
//

import UIKit

class notificationCell: UITableViewCell {
    
    static let reuseIdentifire = String(describing: notificationCell.self)
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

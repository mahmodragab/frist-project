//
//  TableViewCell.swift
//  frist-project
//
//  Created by abdallah ragab on 01/08/2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var imagge: UIImageView!
    static let reuseidentifire = String(describing: TableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

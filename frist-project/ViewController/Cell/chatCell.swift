//
//  chatCell.swift
//  frist-project
//
//  Created by abdallah ragab on 07/10/2022.
//

import UIKit

class chatCell: UITableViewCell {

    @IBOutlet weak var chatImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var lastMessageLbl: UILabel!
    @IBOutlet weak var timeActiveLbl: UILabel!
    @IBOutlet weak var activeLbl: UILabel!
    
    static let reuseIdentifire = String(describing: chatCell.self)
}

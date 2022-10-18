//
//  senderMessageCell.swift
//  frist-project
//
//  Created by abdallah ragab on 10/10/2022.
//

import UIKit

class senderMessageCell: UITableViewCell {

    static let reuseIdentifire = String(describing: senderMessageCell.self)

    @IBOutlet weak var senderImg: UIImageView!

    @IBOutlet weak var messgeLbl: UITextView!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var seenLbl: UILabel!

}

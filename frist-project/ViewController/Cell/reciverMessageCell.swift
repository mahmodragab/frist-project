//
//  reciverMessageCell.swift
//  frist-project
//
//  Created by abdallah ragab on 10/10/2022.
//

import UIKit

class reciverMessageCell: UITableViewCell {

    static let reuseIdentifire = String(describing: reciverMessageCell.self)

    @IBOutlet weak var reciverImg: UIImageView!
    @IBOutlet weak var messReciverLbl: UILabel!
    @IBOutlet weak var timeRceLbl: UILabel!

    @IBOutlet weak var seenRecLbl: UILabel!
}

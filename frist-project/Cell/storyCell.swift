//
//  storyCell.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class storyCell: UICollectionViewCell {
    static let reuseIdentifire = String(describing: storyCell.self)
    
    @IBOutlet weak var storyBtn: UIButton!
    
    @IBOutlet weak var storyImage: UIImageView!
}

//
//  personalPhotoCell.swift
//  frist-project
//
//  Created by abdallah ragab on 03/08/2022.
//

import UIKit

class personalPhotoCell: UICollectionViewCell {
    
    static let reuseIdentifire = String(describing: personalPhotoCell.self)
    
    
    @IBOutlet weak var storyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
   
}

//
//  searchCollectionViewCell.swift
//  frist-project
//
//  Created by abdallah ragab on 02/10/2022.
//

import UIKit

class searchCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifire = String(describing: searchCollectionViewCell.self)

    @IBOutlet weak var searchImg: UIImageView!
    
    @IBOutlet weak var nameSearchLbl: UILabel!
}

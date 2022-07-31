//
//  textfield.swift
//  frist-project
//
//  Created by abdallah ragab on 30/07/2022.
//

import UIKit

class textfield: UITextField {
    
    
    override func awakeFromNib() {
    super.awakeFromNib()
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        
    }
}

//
//  textfield.swift
//  frist-project
//
//  Created by abdallah ragab on 30/07/2022.
//

import UIKit

class ManageTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
    override func awakeFromNib() {
    super.awakeFromNib()
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor

    }
}

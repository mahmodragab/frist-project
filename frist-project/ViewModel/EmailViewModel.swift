//
//  EmailViewModel.swift
//  frist-project
//
//  Created by abdallah ragab on 29/08/2022.
//

import Foundation
import UIKit

class EmailViewModel {
    
    lazy var isValidEmail = Box<(String?, Bool?)> (value: (nil , nil ))
    
    func invalidEmail(_ value: String) {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            isValidEmail.value = (NSLocalizedString("Invalid Email Address", comment: "") , false)
        } else {
            isValidEmail.value = (nil, true)
        }
        
    }
}

//
//  PasswordViewModel.swift
//  frist-project
//
//  Created by abdallah ragab on 29/08/2022.
//

import Foundation
import SwiftLoader

class PasswordViewModel {

    lazy var isValidPassword = Box<(String?, Bool?)>(value: (nil, nil))
    lazy var isValidConfirmPassword = Box<(String?, Bool?)>(value: (nil, nil))
    var password: String = ""
    var registerResponse = Box<String?>(value: nil)


    func invalidPassword(_ value: String) {
        if value.count < 8 {
            isValidPassword.value = (NSLocalizedString("Password must be at least 8 characters", comment: ""), false)
        } else if containsDigit(value) {
            isValidPassword.value = (NSLocalizedString("Password must contain at least 1 digit", comment: ""), false)
        } else if containsLowerCase(value) {
            isValidPassword.value = (NSLocalizedString("Password must contain at least 1 lowercase character", comment: ""), false)
        } else if containsUpperCase(value) {
            isValidPassword.value = (NSLocalizedString("Password must contain at least 1 uppercase character", comment: ""), false)
        } else { isValidPassword.value = (nil, true) }

    }

    func validatConfirmPass(confirmPass: String) {
        if password == confirmPass {
            isValidConfirmPassword.value = ("", true)
        } else {
            isValidConfirmPassword.value = ("Password Not Match", false)
        }

    }

    func containsDigit(_ value: String) -> Bool {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }

    func containsLowerCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }

    func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
}

extension PasswordViewModel {
    func register (model: CreateUserModel) {
        SwiftLoader.show(title: "Loading...", animated: true)
        AuthServiceManager.shared.Register(model: model) { userModel in
            SwiftLoader.hide()
            self.registerResponse.value = userModel
        }
    }
}

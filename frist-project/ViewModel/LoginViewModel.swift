//
//  LoginViewModel.swift
//  frist-project
//
//  Created by abdallah ragab on 28/08/2022.
//

import Foundation
import SwiftLoader

class LoginViewModel {


    var loginResponse = Box<UserInfo?>(value: nil)


    // status  -  msg

    lazy var isValidEmail = Box<(String?, Bool?)>(value: (nil, nil))
    lazy var isValidPassword = Box<(String?, Bool?)>(value: (nil, nil))


    func invalidEmail(_ value: String) {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            isValidEmail.value = (NSLocalizedString("Invalid Email Address", comment: ""), false)
        } else {
            isValidEmail.value = (nil, true)
        }
    }


    func invalidPassword(_ value: String) {
        if value.count < 8 {
            isValidPassword.value = ("Password must be at least 8 characters", false)
        } else
        if containsDigit(value) {
            isValidPassword.value = ("Password must contain at least 1 digit", false)
        } else
        if containsLowerCase(value) {
            isValidPassword.value = ("Password must contain at least 1 lowercase character", false)
        } else
        if containsUpperCase(value) {
            isValidPassword.value = ("Password must contain at least 1 uppercase character", false)
        } else { isValidPassword.value = (nil, true) }

    }

    func containsDigit(_ value: String) -> Bool {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }

    func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }

    func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }



}

extension LoginViewModel {
    func login (model: LoginUserModel) {
        SwiftLoader.show(title: "Loading...", animated: true)
        AuthServiceManager.shared.login(model: model) { userInfo in
            SwiftLoader.hide()
            self.loginResponse.value = userInfo
        }
    }
}

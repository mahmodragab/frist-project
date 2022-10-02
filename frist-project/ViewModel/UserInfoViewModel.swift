//
//  UserInfoViewModel.swift
//  frist-project
//
//  Created by abdallah ragab on 01/10/2022.
//

import Foundation


class UserInfoViewModel {
    var model = CreateUserModel()

    lazy var isValidFirstName = Box<(String?, Bool?)>(value: (nil, nil))
    lazy var isValidLastName = Box<(String?, Bool?)>(value: (nil, nil))
    lazy var isFormValid = Box<(Bool)>(value: false)

    func isValidFirstName(_ value: String) {
        if value.isEmpty {
            isValidFirstName.value = (NSLocalizedString("invalid frist Name Address", comment: ""), false)
        } else {
            isValidFirstName.value = (nil, true)
        }
        checkValidation()
    }



    func isValidLastName(_ value: String) {
        if value.isEmpty {
            isValidLastName.value = (NSLocalizedString("invalid last Name Address", comment: ""), false)
        } else {
            isValidLastName.value = (nil, true)
        }
        checkValidation()
    }

    func checkValidation() {
        if isValidFirstName.value.1 == true && isValidLastName.value.1 == true {
            isFormValid.value = true
        } else {
            isFormValid.value = false
        }
    }




}

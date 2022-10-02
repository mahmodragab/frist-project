//
//  step3VC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit
import Alamofire
import CoreData
import SwiftLoader

class PasswordViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var createPassLbl: UILabel!
    @IBOutlet weak var MessageLbl: UILabel!

    @IBOutlet weak var passwordTF: ManageTextField!
    @IBOutlet weak var rePasswordTF: ManageTextField!

    @IBOutlet weak var passErrorLbl: UILabel!
    @IBOutlet weak var rePassErrorLbl: UILabel!

    @IBOutlet weak var nextBtn: facebookBtn!

    // MARK: - Variables -

    var model = CreateUserModel()
    let defaults = UserDefaults.standard
    var viewModel = PasswordViewModel()

    // MARK: - LifeCycle -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpFormTextField()
        setlocalization()
        setDefaultState()

        print("user information \(createPassword().fristName) \(createPassword().lastname) \(createPassword().email) ")

        viewModel.registerResponse.bind { response in
            if let msg = response {
                AlertMessage.showMessage(message: msg, title: "success", on: self) { (_) -> Void in
                    self.navigateToLoginViewController()
                }
            } else {
                AlertMessage.showMessage(message: "something went wrong", title: "ERROR", on: self)
            }

        }


        viewModel.isValidPassword.bind { (msg, isValid) in
            if isValid ?? false {
                self.passErrorLbl.text = msg
                self.passErrorLbl.isHidden = true
            } else {
                self.passErrorLbl.text = msg
                self.passErrorLbl.isHidden = false
            }
        }

        viewModel.isValidConfirmPassword.bind { (msg, isValid) in
            if isValid ?? false {
                self.rePassErrorLbl.text = msg
                self.rePassErrorLbl.isHidden = true
            } else {
                self.rePassErrorLbl.text = msg
                self.rePassErrorLbl.isHidden = false
            }
        }
    }

    // MARK: - IBAction -

    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTF.text {
            viewModel.password = passwordTF.text ?? ""
            viewModel.invalidPassword(password)
        }
    }

    @IBAction func rePasswordChanged(_ sender: UITextField) {
        if let repassword = rePasswordTF.text {
            viewModel.validatConfirmPass(confirmPass: repassword)
        }
        checkForValidForm()
    }

    @IBAction func nextBtn(_ sender: Any) {
        viewModel.register(model: model)
//        Register(model: model) { [self] response in
//            switch response {
//            case .success(let msg):
//                AlertMessage.showMessage(message: msg, title: "success", on: self) { (_) -> Void in
//                    navigateToLoginViewController()
//                }
//            case .failure(let error):
//                AlertMessage.showMessage(message: "something went wrong", title: "ERROR", on: self)
//            }
//        }
    }

    @IBAction func showPassword(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry

    }
    @IBAction func showRepassword(_ sender: Any) {
        rePasswordTF.isSecureTextEntry = !rePasswordTF.isSecureTextEntry
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate -

extension PasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTF {
            return rePasswordTF.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}

// MARK: - Convert Data To Dictionary -

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

// MARK: - Network layer -

//extension PasswordViewController {
//
//    func Register(model: CreateUserModel, completion: @escaping (Result<String, Error>) -> Void) {
//        //TODO: start loader here
//        SwiftLoader.show(title: "Loading...", animated: true)
//        let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/register"
//        let params = model.dictionary
//        AF.request(path, method: .post, parameters: params).responseDecodable(of: CreateAccountResponse.self) { response in
//            //TODO: hide loader here
//            SwiftLoader.hide()
//            switch response.result {
//            case .success(let response):
//                completion(.success((response.message)))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//}

//MARK: - Helpers Functions -

extension PasswordViewController {

    func createPassword() -> CreateUserModel {
        model.password = passwordTF.text ?? ""
        model.password = rePasswordTF.text ?? ""
        return model
    }

    func navigateToLoginViewController() {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func setUpFormTextField() {
        self.passwordTF.delegate = self
        self.rePasswordTF.delegate = self
    }

    func setlocalization() {
        self.createPassLbl.text = NSLocalizedString("createPassLbl", comment: "")
        self.MessageLbl.text = NSLocalizedString("MessageLbl", comment: "")
        self.passwordTF.placeholder = NSLocalizedString("passwordTF", comment: "")
        self.rePasswordTF.placeholder = NSLocalizedString("rePasswordTF", comment: "")
        self.passErrorLbl.text = NSLocalizedString("passErrorLbl", comment: "")
        self.rePassErrorLbl.text = NSLocalizedString("rePassErrorLbl", comment: "")
        self.nextBtn.setTitle(NSLocalizedString("nextBtn", comment: ""), for: .normal)

    }

    func saveJSONModel() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            defaults.set(encoded, forKey: "SavedUser")
            defaults.synchronize()
        }
    }
    func loadJSONModel() {

        if let savedUser = defaults.object(forKey: "SavedUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedModel = try? decoder.decode(CreateUserModel.self, from: savedUser) {
                print(loadedModel.email)
            }
        }
    }

    func setDefaultState() {
        nextBtn.isEnabled = false

        passErrorLbl.text = ""
        rePassErrorLbl.text = ""
    }

    func checkForValidForm() {
        if viewModel.isValidPassword.value.1 ?? false && viewModel.isValidConfirmPassword.value.1 ?? false {
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
    }

}

//extension String {
////    func toObject<T: Decodable>() -> T? {
////        do {
////            let decoder = JSONDecoder()
////            let jsonData = self.data(using: .utf8)!
////            let parsedData = try decoder.decode(T.self, from: jsonData)
////            return parsedData
////        }
////        catch {
////            print(error)
////        }
////        return nil
////    }
//
//    func toDictionary() -> [String: AnyObject]? {
//        if let data = self.data(using: .utf8) {
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
//                return json
//            }
//            catch {
//                print(error)
//            }
//        }
//        return nil
//    }
//}


// MARK: - CreateAccountResponse
//struct CreateAccountResponse: Codable {
//    let message: String
//    let statusCode: Int
//
//    enum CodingKeys: String, CodingKey {
//        case message = "Message"
//        case statusCode = "StatusCode"
//    }
//}



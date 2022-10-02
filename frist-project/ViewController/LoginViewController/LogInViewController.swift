//
//  login2VC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit
import SwiftLoader
import Alamofire

class LogInViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var loginLbl: UILabel!

    @IBOutlet weak var emailTF: ManageTextField!
    @IBOutlet weak var emailErrorLbl: UILabel!

    @IBOutlet weak var passwordTF: ManageTextField!
    @IBOutlet weak var passwordErorrLbl: UILabel!

    @IBOutlet weak var forgotpassBtn: UIButton!
    @IBOutlet weak var DonthaveLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var LogInBtn: facebookBtn!

    // MARK: - Variables -

    let defaults = UserDefaults.standard
    var viewModel = LoginViewModel()

    // MARK: - LifeCycle -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalization()
        setDefaultState()
        setUpFormTextField()
        

        viewModel.loginResponse.bind { (userInfo) in
            if let user = userInfo {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(user) {
                    self.defaults.set(encoded, forKey: "SavedDataResponse")
                    self.defaults.synchronize()
                }
                self.navigateToMainController()
            } else {
                print("error")
            }
        }

        viewModel.isValidEmail.bind { (msg, isValid) in
            if isValid ?? false {
                self.emailErrorLbl.text = msg
                self.emailErrorLbl.isHidden = true
            } else {
                self.emailErrorLbl.text = msg
                self.emailErrorLbl.isHidden = false
            }
        }

        viewModel.isValidPassword.bind { (msg, isValid) in
            if isValid ?? false {
                self.passwordErorrLbl.text = msg
                self.passwordErorrLbl.isHidden = true
            } else {
                self.passwordErorrLbl.text = msg
                self.passwordErorrLbl.isHidden = false
            }

        }
    }

    // MARK: - IBAction -

    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTF.text {
            viewModel.invalidEmail(email)
        }
        checkForValidForm()
    }


    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTF.text {
            viewModel.invalidPassword(password)
        }
        checkForValidForm()
    }

    @IBAction func showPassword(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }

    @IBAction func LoginBtn(_ sender: Any) {
        let model = LoginUserModel(email: emailTF.text ?? "", password: passwordTF.text ?? "")
        viewModel.login(model: model)
//        Login(model: model) { [self] response in
//            switch response {
//            case .success(let response):
//                //MARK: we can save user info here
//                let encoder = JSONEncoder()
//                if let encoded = try? encoder.encode(response) {
//                    defaults.set(encoded, forKey: "SavedDataResponse")
//                    defaults.synchronize()
//                }
//                navigateToMainController()
//            case .failure(_): break
//
//            }
//        }
    }

    @IBAction func signUpBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController else { return }
        self.navigationController?.pushViewController(VC, animated: true)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITextFieldDelegate -

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            return passwordTF.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}

// MARK: - Network layer -

extension LogInViewController {
//    func Login(model: LoginUserModel, completion: @escaping (Result<UserInfo?, Error>) -> Void) {
//        //TODO: start loader here
//        SwiftLoader.show(title: "Loading...", animated: true)
//        let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/login"
//        let params = model.dictionary
//        AF.request(path, method: .post, parameters: params).responseDecodable(of: UserInfoResponse.self) { response in
//            //TODO: hide loader here
//            SwiftLoader.hide()
//            switch response.result {
//            case .success(let response):
//                //MARK: can save user info here
//
//                completion(.success((response.data)))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}

//MARK: - Helpers Functions -

extension LogInViewController {

    func setUpFormTextField() {
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
    }

    func setLocalization() {
        self.loginLbl.text = NSLocalizedString("loginLbl", comment: "")
        self.emailTF.placeholder = NSLocalizedString("emailTF", comment: "")
        self.passwordTF.placeholder = NSLocalizedString("passwordTF", comment: "")
        self.emailErrorLbl.text = NSLocalizedString("emailErrorLbl", comment: "")
        self.passwordErorrLbl.text = NSLocalizedString("passwordErorrLbl", comment: "")
        self.forgotpassBtn.setTitle(NSLocalizedString("forgotpassBtn", comment: ""), for: .normal)
        self.DonthaveLbl.text = NSLocalizedString("DonthaveLbl", comment: "")
        self.LogInBtn.setTitle(NSLocalizedString("LogInBtn", comment: ""), for: .normal)
        self.signUpBtn.setTitle(NSLocalizedString("signUpBtn", comment: ""), for: .normal)
    }

    func navigateToMainController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TabeBarMainViewController") as? TabeBarMainViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }


    func setDefaultState() {
        LogInBtn.isEnabled = false
        emailErrorLbl.text = ""
        passwordErorrLbl.text = ""
    }

    func checkForValidForm() {
        if viewModel.isValidEmail.value.1 ?? false && viewModel.isValidPassword.value.1 ?? false {
            LogInBtn.isEnabled = true
        } else {
            LogInBtn.isEnabled = false
        }
    }
}

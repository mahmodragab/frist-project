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
    
    var model = CreateUserModel()
    let defaults = UserDefaults.standard

    
    @IBOutlet weak var loginLbl: UILabel!
    
    @IBOutlet weak var emailTF: textfield!
    @IBOutlet weak var passwordTF: textfield!
    
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordErorrLbl: UILabel!
    @IBOutlet weak var forgotpassBtn: UIButton!
    @IBOutlet weak var DonthaveLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var LogInBtn: facebookBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Localization()
        
        resetForm()
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
    }
    
    
    func Localization() {
        self.loginLbl.text = NSLocalizedString("loginLbl", comment: "")
        self.emailTF.placeholder = NSLocalizedString("emailTF", comment: "")
        self.passwordTF.placeholder = NSLocalizedString("passwordTF", comment: "")
        self.emailErrorLbl.text = NSLocalizedString("emailErrorLbl", comment: "")
        self.passwordErorrLbl.text = NSLocalizedString("passwordErorrLbl", comment: "")
        self.forgotpassBtn.titleLabel?.text = NSLocalizedString("forgotpassBtn", comment: "")
        self.DonthaveLbl.text = NSLocalizedString("DonthaveLbl", comment: "")
        self.LogInBtn.titleLabel?.text = NSLocalizedString("LogInBtn", comment: "")
        self.signUpBtn.titleLabel?.text = NSLocalizedString("signUpBtn", comment: "")
    }
    
    func Login(model: CreateUserModel, completion: @escaping (Result<UserInfo?, Error>) -> Void) {
        //TODO: start loader here
        SwiftLoader.show(title: "Loading...", animated: true)
      let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/login"
       let params = model.dictionary
        AF.request(path, method: .post, parameters: params ).responseDecodable(of: UserInfoResponse.self) { response in
          //TODO: hide loader here
          SwiftLoader.hide()
        switch response.result {
        case .success(let response):
            //MARK: can save user info here
            completion(.success((response.data)))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
    
    
    func resetForm() {
        LogInBtn.isEnabled = false
        
        emailErrorLbl.text = ""
        passwordErorrLbl.text = ""
        
//        emailTF.text = model.email
//        passwordTF.text = model.password
//        if emailTF.text == model.email && passwordTF.text == model.password{
//        finishBtN.isEnabled = true
//        } else {finishBtN.isEnabled = false}
    }
     
    func checkForValidForm() {
        if emailErrorLbl.isHidden && passwordErorrLbl.isHidden  {
            LogInBtn.isEnabled = true
        } else {
            LogInBtn.isEnabled = false
        }
    }
    func invalidEmail(_ value: String) -> String? {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            return NSLocalizedString("Invalid Email Address", comment: "")
        }
        return nil
    }
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTF.text{
            if let errorMessage = invalidEmail(email)  {
                emailErrorLbl.text = errorMessage
                emailErrorLbl.isHidden = false
            } else {
                emailErrorLbl.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    func invalidPassword(_ value: String) -> String?{
        if value.count < 8{
            return "Password must be at least 8 characters"
        }
        if containsDigit(value){
            return "Password must contain at least 1 digit"
        }
        if containsLowerCase(value){
            return "Password must contain at least 1 lowercase character"
        }
        if containsUpperCase(value){
            return "Password must contain at least 1 uppercase character"
        }
        return nil
    }
    
    func containsDigit(_ value: String) -> Bool{
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool{
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool{
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTF.text{
            if let errorMessage = invalidPassword(password)  {
                passwordErorrLbl.text = errorMessage
                passwordErorrLbl.isHidden = false
            } else {
                passwordErorrLbl.isHidden = true
            }
        }
        checkForValidForm()
        }
     
    
    
  
    @IBAction func showPassword(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    func navigateToMainController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    @IBAction func finishBtn(_ sender: Any) {
//        resetForm()
        
        Login(model: model) { [self] response in
            switch response {
            case .success(let response):
                //MARK: we can save user info here
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(response) {
                    defaults.set(encoded, forKey: "SavedDataResponse")
                    defaults.synchronize()
                }
                    navigateToMainController()
            case .failure(let error): break
                
            }
         
            }
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController else{ return }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

extension LogInViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == emailTF {
        return passwordTF.becomeFirstResponder()
      } else {
         return textField.resignFirstResponder()
      }
   }
}

//extension Date {
//  func asString(style: DateFormatter.Style) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateStyle = style
//    return dateFormatter.string(from: self)
//  }
//}


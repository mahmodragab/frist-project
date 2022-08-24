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
    var model = CreateUserModel()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var createPassLbl: UILabel!
    @IBOutlet weak var MessageLbl: UILabel!
    
    @IBOutlet weak var passwordTF: textfield!
    @IBOutlet weak var rePasswordTF: textfield!
    
    @IBOutlet weak var passErrorLbl: UILabel!
    @IBOutlet weak var rePassErrorLbl: UILabel!
    
    @IBOutlet weak var nextBtn: facebookBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTF.delegate = self
        self.rePasswordTF.delegate = self
        localization()
        
        resetForm()
        print("user information \(createPassword().fristName) \(createPassword().lastname) \(createPassword().email) ")
//        saveJSONModel()
//        loadJSONModel()
    }
    func localization() {
        self.createPassLbl.text = NSLocalizedString("createPassLbl", comment: "")
        self.MessageLbl.text = NSLocalizedString("MessageLbl", comment: "")
        self.passwordTF.placeholder = NSLocalizedString("passwordTF", comment: "")
        self.rePasswordTF.placeholder = NSLocalizedString("rePasswordTF", comment: "")
        self.passErrorLbl.text = NSLocalizedString("passErrorLbl", comment: "")
        self.rePassErrorLbl.text = NSLocalizedString("rePassErrorLbl", comment: "")
        self.nextBtn.titleLabel?.text = NSLocalizedString("nextBtn", comment: "")
        
    }

    
    func Register(model: CreateUserModel, completion: @escaping (Result<String, Error>) -> Void) {
        //TODO: start loader here
        SwiftLoader.show(title: "Loading...", animated: true)
      let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/register"
       let params = model.dictionary
      AF.request(path, method: .post, parameters: params).responseDecodable(of: CreateAccountResponse.self) { response in
          //TODO: hide loader here
          SwiftLoader.hide()
        switch response.result {
        case .success(let response):
            completion(.success((response.message)))
        case .failure(let error):
          completion(.failure(error))
        }
      }
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
    
    func resetForm() {
        nextBtn.isEnabled = false
    
        passErrorLbl.text = ""
        rePassErrorLbl.text = ""
    }
    
    func checkForValidForm() {
        if passErrorLbl.isHidden && rePassErrorLbl.isHidden {
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
        if passwordTF.text == rePasswordTF.text{
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
        
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTF.text{
            if let errorMessage = invalidPassword(password){
                passErrorLbl.text = errorMessage
                passErrorLbl.isHidden = false
            } else {
                passErrorLbl.isHidden = true
            }
        }
        
        checkForValidForm()
    }
    func invalidPassword(_ value: String) -> String?{
        if value.count < 8 {
            return NSLocalizedString("Password must be at least 8 characters", comment: "")
        }
        if containsDigit(value){
            return NSLocalizedString("Password must contain at least 1 digit", comment: "")
        }
        if containsLowerCase(value){
            return NSLocalizedString("Password must contain at least 1 lowercase character", comment: "")
        }
        if containsUpperCase(value){
            return NSLocalizedString("Password must contain at least 1 uppercase character", comment: "")
        }
        return nil
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
    
    @IBAction func rePasswordChanged(_ sender: Any) {
        if let password = rePasswordTF.text {
            if let errorMessage = invalidPassword(password) {
                rePassErrorLbl.text = errorMessage
                rePassErrorLbl.isHidden = false
            } else {
                rePassErrorLbl.isHidden = true
            }
        }
        checkForValidForm()
    }
    func createPassword() -> CreateUserModel{
        model.password = passwordTF.text ?? ""
        model.password = rePasswordTF.text ?? ""
        return model
    }
    
    func navigateToLoginViewController(){
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else { return}
        vc.model = createPassword()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
       
        Register(model: model) { [self] response in
            switch response {
            case .success(let msg):
                AlertMessage.showMessage(message: msg, title: "success", on: self) {  (_) -> Void in
                    navigateToLoginViewController()
                }
            case .failure(let error):
                AlertMessage.showMessage(message: "something went wrong", title: "ERROR", on: self)
            }
          }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

extension PasswordViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == passwordTF {
        return rePasswordTF.becomeFirstResponder()
      } else {
         return textField.resignFirstResponder()
      }
   }
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
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



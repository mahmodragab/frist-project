//
//  step1VC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
//    let userdefaults = UserDefaults.standard
    var model = CreateUserModel()
    
    @IBOutlet weak var whatYNLbl: UILabel!
    @IBOutlet weak var FristNameTF: textfield!
    @IBOutlet weak var LastNameTF: textfield!
    @IBOutlet weak var errorFristLB: UILabel!
    @IBOutlet weak var errorLastLB: UILabel!
    @IBOutlet weak var NextBTN: facebookBtn!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        self.FristNameTF.delegate = self
        self.LastNameTF.delegate = self
        
      localization()
    }
   
    func localization() {
        self.whatYNLbl.text = NSLocalizedString("whatYNLbl", comment: "")
        self.FristNameTF.placeholder = NSLocalizedString("FristNameTF", comment: "")
        self.LastNameTF.placeholder = NSLocalizedString("LastNameTF", comment: "")
        self.errorFristLB.text = NSLocalizedString("errorFristLB", comment: "")
        self.errorLastLB.text = NSLocalizedString("errorLastLB", comment: "")
        self.NextBTN.titleLabel?.text = NSLocalizedString("NextBTN", comment: "")
    }
    
    func resetForm() {
        NextBTN.isEnabled = false
        
        errorFristLB.isHidden = false
        errorLastLB.isHidden = false
        
        errorFristLB.text = ""
        errorLastLB.text = ""
        
    
    }
    
    func checkForValidForm() {
        if errorFristLB.isHidden && errorLastLB.isHidden {
            NextBTN.isEnabled = true
        } else {
            NextBTN.isEnabled = false
        }
    }
    
    
    @IBAction func fristNameChanged(_ sender: Any) {
        if let fristName = FristNameTF.text {
            if fristName.isEmpty {
                errorFristLB.text = NSLocalizedString("invalid frist Name Address", comment: "") 
                errorFristLB.isHidden = false
            } else {
                errorFristLB.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    
    
    @IBAction func lastNameChanged(_ sender: Any) {
        if let lastName = LastNameTF.text {
            if lastName.isEmpty {
                errorLastLB.text = NSLocalizedString("invalid last Name Address", comment: "")
                errorLastLB.isHidden = false
            } else {
                errorLastLB.isHidden = true
            }
        }
        checkForValidForm()
    }
        
    
    func createSignupUserModel() -> CreateUserModel {
        
        model.fristName = FristNameTF.text ?? ""
        model.lastname = LastNameTF.text ?? ""
        return model
    }
    
    func navigateToUserNameViewController()  {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "EmailViewController") as? EmailViewController else { return }
        vc.model = createSignupUserModel()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        resetForm()
        navigateToUserNameViewController()
        
        
//        var userDict: [String:Any] = [:]
//
//        userDict.updateValue(FristNameTF.text ?? "", forKey: "fristname")
//        userDict.updateValue(LastNameTF.text ?? "", forKey: "lastname")
//
//        userDict["fristname"] = FristNameTF.text ?? "
        // TODO: using codable object -
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
extension UserInfoViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == FristNameTF {
        return LastNameTF.becomeFirstResponder()
      } else {
         return textField.resignFirstResponder()
      }
   }
}

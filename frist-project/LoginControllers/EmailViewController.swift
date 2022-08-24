//
//  step2VS.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class EmailViewController: UIViewController {
    

    @IBOutlet weak var whatEmailLbl: UILabel!
    @IBOutlet weak var emailTF: textfield!
    @IBOutlet weak var errorLB: UILabel!
    @IBOutlet weak var nextBtn: facebookBtn!

    var model = CreateUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localization()
        
        print("user model \(createEmailModel().fristName) \(createEmailModel().lastname)")
        resetForm()
        self.emailTF.delegate = self
    }
    
    func localization() {
        self.whatEmailLbl.text = NSLocalizedString("whatEmailLbl", comment: "")
        self.emailTF.placeholder = NSLocalizedString("emailTF", comment: "")
        self.errorLB.text = NSLocalizedString("errorLB", comment: "")
        self.nextBtn.titleLabel?.text = NSLocalizedString("nextBtn", comment: "")
    }
    
    func resetForm() {
        nextBtn.isEnabled = false
        
        errorLB.text = ""
    }
    
    func checkForValidForm() {
        if errorLB.isHidden {
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
    }
    func createEmailModel() -> CreateUserModel{
        model.email = emailTF.text ?? ""
        return model
    }
    
    func navigateToPasswordViewController() {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "PasswordViewController") as? PasswordViewController else { return }
                vc.model = createEmailModel()
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        resetForm()
        navigateToPasswordViewController()

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
        if let email = emailTF.text {
            if let errorMessage = invalidEmail(email) {
                errorLB.text = errorMessage
                errorLB.isHidden = false
            } else {
                errorLB.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension EmailViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//      let nextTag = textField.tag + 1
//       let nextTF = textField.superview?.viewWithTag(nextTag) as UIResponder?
      if textField == emailTF {
//        return LastNameTF.becomeFirstResponder()
//      } else {
         return emailTF.resignFirstResponder()
//      }
//      return false
   }
       return false
}
}

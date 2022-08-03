//
//  step3VC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class step3VC: UIViewController {
    
    @IBOutlet weak var passwordTF: textfield!
    @IBOutlet weak var rePasswordTF: textfield!
    
    @IBOutlet weak var passErrorLbl: UILabel!
    @IBOutlet weak var rePassErrorLbl: UILabel!
    
    @IBOutlet weak var nextBtn: facebookBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()

        // Do any additional setup after loading the view.
    }
    func resetForm() {
        nextBtn.isEnabled = false
        
        passwordTF.text = ""
        rePasswordTF.text = ""
        
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
            }else{
                passErrorLbl.isHidden = true
            }
        }
        
        checkForValidForm()
        
    }
    func invalidPassword(_ value: String) -> String?{
        if value.count < 8 {
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
    
    @IBAction func nextBtn(_ sender: Any) {
        resetForm()
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "login2VC") as? login2VC else { return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        
    }
    @IBAction func showRepassword(_ sender: Any) {
        rePasswordTF.isSecureTextEntry = !rePasswordTF.isSecureTextEntry
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  login2VC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class login2VC: UIViewController {
    @IBOutlet weak var emailTF: textfield!
    @IBOutlet weak var passwordTF: textfield!
    
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordErorrLbl: UILabel!
    
    @IBOutlet weak var finishBtN: facebookBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func resetForm() {
        finishBtN.isEnabled = false
        
        emailErrorLbl.text = ""
        passwordErorrLbl.text = ""
        
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    func checkForValidForm() {
        if emailErrorLbl.isHidden && passwordErorrLbl.isHidden  {
            finishBtN.isEnabled = true
        } else {
            finishBtN.isEnabled = false
        }
    }
    func invalidEmail(_ value: String) -> String? {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            return "Invalid Email Address"
        }
        return nil
    }
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTF.text {
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
            if let errorMessage = invalidPassword(password){
                passwordErorrLbl.text = errorMessage
                passwordErorrLbl.isHidden = false
            }else{
                passwordErorrLbl.isHidden = true
            }
        }
        checkForValidForm()
    }
    
  
    @IBAction func showPassword(_ sender: Any) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    
    @IBAction func finishBtn(_ sender: Any) {
        resetForm()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else{ return }
        self.navigationController?.pushViewController(VC, animated: true)
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

//
//  step2VS.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class step2VC: UIViewController {
    
    @IBOutlet weak var emailTF: textfield!
    @IBOutlet weak var errorLB: UILabel!
    @IBOutlet weak var nextBtn: facebookBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
    }
    
    func resetForm() {
        nextBtn.isEnabled = false
        
        errorLB.text = ""
        
        emailTF.text = ""
    }
    
    func checkForValidForm() {
        if errorLB.isHidden {
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        resetForm()
        
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "step3VC") as? step3VC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
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
            if let errorMessage = invalidEmail(email) {
                errorLB.text = errorMessage
                errorLB.isHidden = false
            } else {
                errorLB.isHidden = true
            }
        }
        checkForValidForm()
    }
    
}

//
//  step1VC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class step1VC: UIViewController {
    
    @IBOutlet weak var FristNameTF: textfield!
    @IBOutlet weak var LastNameTF: textfield!
    @IBOutlet weak var errorFristLB: UILabel!
    @IBOutlet weak var errorLastLB: UILabel!
    @IBOutlet weak var NextBTN: facebookBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()

    }
    func resetForm() {
        NextBTN.isEnabled = false
        
        errorFristLB.isHidden = false
        errorLastLB.isHidden = false
        
        errorFristLB.text = ""
        errorLastLB.text = ""
        
        FristNameTF.text = ""
        LastNameTF.text = ""
        
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
                errorFristLB.text = "invalid frist Name Address"
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
                errorLastLB.text = "invalid Last Name Address"
                errorLastLB.isHidden = false
            } else {
                errorLastLB.isHidden = true
            }
        }
        checkForValidForm()
    }
        
    
    
    @IBAction func nextBtn(_ sender: Any) {
        
        resetForm()
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "step2VC") as? step2VC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
       
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

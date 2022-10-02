//
//  step2VS.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class EmailViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var whatEmailLbl: UILabel!
    @IBOutlet weak var emailTF: ManageTextField!
    @IBOutlet weak var errorLB: UILabel!
    @IBOutlet weak var nextBtn: facebookBtn!

    // MARK: - Variables -

    var model = CreateUserModel()
    var viewModel = EmailViewModel()

    // MARK: - LifeCycle -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setlocalization()
        print("user model \(createEmailModel().fristName) \(createEmailModel().lastname)")
        setDefaultState()
        self.emailTF.delegate = self
        
        viewModel.isValidEmail.bind{ (msg , isValid) in
            if isValid ?? false {
                self.errorLB.text = msg
                self.errorLB.isHidden = true
            } else {
                self.errorLB.text = msg
                self.errorLB.isHidden = false
            }
        }
    }

    // MARK: - IBActions -

    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTF.text {
            viewModel.invalidEmail(email)
        }
        checkForValidForm()
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func nextBtn(_ sender: Any) {
        setDefaultState()
        navigateToPasswordViewController()

    }

}

// MARK: - UITextFieldDelegate -

extension EmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF {
            return emailTF.resignFirstResponder()
        }
        return false
    }
}

//MARK: - Helpers Functions -

extension EmailViewController {

    func setlocalization() {
        self.whatEmailLbl.text = NSLocalizedString("whatEmailLbl", comment: "")
        self.emailTF.placeholder = NSLocalizedString("emailTF", comment: "")
        self.errorLB.text = NSLocalizedString("errorLB", comment: "")
        self.nextBtn.setTitle(NSLocalizedString("nextBtn", comment: ""), for: .normal)
    }

    func setDefaultState() {
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
    func createEmailModel() -> CreateUserModel {
        model.email = emailTF.text ?? ""
        return model
    }

    func navigateToPasswordViewController() {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "PasswordViewController") as? PasswordViewController else { return }
        vc.model = createEmailModel()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

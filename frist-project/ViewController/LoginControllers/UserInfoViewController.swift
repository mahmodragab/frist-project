//
//  step1VC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class UserInfoViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var whatYNLbl: UILabel!

    @IBOutlet weak var FristNameTF: ManageTextField!
    @IBOutlet weak var LastNameTF: ManageTextField!
    @IBOutlet weak var errorFristLB: UILabel!
    @IBOutlet weak var errorLastLB: UILabel!
    @IBOutlet weak var NextBTN: facebookBtn!

    // MARK: - Variables -

    var viewModel = UserInfoViewModel()

    // MARK: - LifeCycle -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultState()
        setUpFormTextField()
        localization()

        viewModel.isValidFirstName.bind { (msg, isValid) in
            if isValid ?? false {
                self.errorFristLB.text = msg
                self.errorFristLB.isHidden = true
            } else {
                self.errorFristLB.text = msg
                self.errorFristLB.isHidden = false
            }
        }

        viewModel.isValidLastName.bind { (msg, isValid) in
            if isValid ?? false {
                self.errorLastLB.text = msg
                self.errorLastLB.isHidden = true
            } else {
                self.errorLastLB.text = msg
                self.errorLastLB.isHidden = false
            }
        }

        viewModel.isFormValid.bind { isValid in
            self.NextBTN.isEnabled = isValid
        }

    }

    // MARK: - IBActions -

    @IBAction func fristNameChanged(_ sender: Any) {
        if let fristName = FristNameTF.text {
            viewModel.isValidFirstName(fristName)
        }
    }

    @IBAction func lastNameChanged(_ sender: Any) {
        if let lastName = LastNameTF.text {
            viewModel.isValidLastName(lastName)
        }
    }

    @IBAction func nextBtn(_ sender: Any) {
//        setDefaultState()
        createSignupUserModel()
        navigateToUserNameViewController()
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITextFieldDelegate -

extension UserInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == FristNameTF {
            return LastNameTF.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}

//MARK: - Helpers Functions -

extension UserInfoViewController {

    func navigateToUserNameViewController() {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "EmailViewController") as? EmailViewController else { return }
        vc.model = viewModel.model
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func createSignupUserModel() {
        viewModel.model.fristName = FristNameTF.text ?? ""
        viewModel.model.lastname = LastNameTF.text ?? ""
    }

    func localization() {
        self.whatYNLbl.text = NSLocalizedString("whatYNLbl", comment: "")
        self.FristNameTF.placeholder = NSLocalizedString("FristNameTF", comment: "")
        self.LastNameTF.placeholder = NSLocalizedString("LastNameTF", comment: "")
        self.errorFristLB.text = NSLocalizedString("errorFristLB", comment: "")
        self.errorLastLB.text = NSLocalizedString("errorLastLB", comment: "")
        self.NextBTN.setTitle(NSLocalizedString("NextBTN", comment: ""), for: .normal)
    }

    func setDefaultState() {
        NextBTN.isEnabled = false

        errorFristLB.isHidden = true
        errorLastLB.isHidden = true

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

    func setUpFormTextField() {
        self.FristNameTF.delegate = self
        self.LastNameTF.delegate = self
    }
}

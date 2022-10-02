//
//  SplashViewController.swift
//  frist-project
//
//  Created by abdallah ragab on 30/07/2022.
//

import UIKit

class IntroViewController: UIViewController {

    // MARK: - IBOutlets -

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var haveAccLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var facebookBtn: facebookBtn!
    @IBOutlet weak var createAccBtn: facebookBtn!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var textLBL: UILabel!

    // MARK: - LifeCycle -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        localization()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        localization()

    }

    // MARK: - IBAction -

    @IBAction func createaccountBtn(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let vc = storyboard.instantiateViewController(withIdentifier: "UserInfoViewController") as? EmailViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc = UserInfoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func loginBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func hyperLinkBtn(_ sender: Any) {
        if let url = URL(string: "https://www.google.com") {
            UIApplication.shared.open(url)
        } else {
            print("url is not correct")

        }
    }
}

//MARK: - Helpers Functions -

extension IntroViewController {

    func localization() {
        self.textLbl.text = NSLocalizedString("textLbl", comment: "")
        self.textLBL.text = NSLocalizedString("textLBL", comment: "")
        self.loginBtn.setTitle(NSLocalizedString("loginBtn", comment: ""), for: .normal)
        self.haveAccLbl.text = NSLocalizedString("haveAccLbl", comment: "")
        self.welcomeLbl.text = NSLocalizedString("welcomeLbl", comment: "")
        self.facebookBtn.setTitle(NSLocalizedString("facebookLbl", comment: ""), for: .normal)
        self.createAccBtn.setTitle(NSLocalizedString("createAccBtn", comment: ""), for: .normal)
    }
}

//
//  SplashViewController.swift
//  frist-project
//
//  Created by abdallah ragab on 30/07/2022.
//

import UIKit

class IntroViewController: UIViewController {

    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var haveAccLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var facebookLbl: facebookBtn!
    @IBOutlet weak var createAccBtn: facebookBtn!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var textLBL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        
    }
    
    func localization() {
        self.textLbl.text = NSLocalizedString("textLbl", comment: "")
        self.textLBL.text = NSLocalizedString("textLBL", comment: "")
        self.loginBtn.titleLabel?.text = NSLocalizedString("loginBtn", comment: "")
        self.haveAccLbl.text = NSLocalizedString("haveAccLbl", comment: "")
        self.welcomeLbl.text = NSLocalizedString("welcomeLbl", comment: "")
        self.facebookLbl.titleLabel?.text = NSLocalizedString("facebookLbl", comment: "")
        self.createAccBtn.titleLabel?.text = NSLocalizedString("createAccBtn", comment: "")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func createaccountBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "UserInfoViewController") as? UserInfoViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func hyperLinkBtn(_ sender: Any) {
        if let url = URL(string: "https://www.google.com")  {
            UIApplication.shared.open(url)
        } else {
            print("url is not correct")
            
        }
    }
}

extension String {

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }


    func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
}
//extension UIButton {
//    func underline() {
//        guard let text = self.titleLabel?.text else { return }
//        let attributedString = NSMutableAttributedString(string: text)
//        //NSAttributedStringKey.foregroundColor : UIColor.blue
//        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
//        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
//        self.setAttributedTitle(attributedString, for: .normal)
//    }
//}

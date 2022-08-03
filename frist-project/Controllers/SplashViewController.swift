//
//  SplashViewController.swift
//  frist-project
//
//  Created by abdallah ragab on 30/07/2022.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func createaccountBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "step1VC") as? step1VC else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "login2VC") as? login2VC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
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

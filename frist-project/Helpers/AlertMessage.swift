//
//  AlertMessage.swift
//  frist-project
//
//  Created by abdallah ragab on 14/08/2022.
//

import UIKit

class AlertMessage {

    static func showMessage(message: String,title: String, on viewController: UIViewController?, dismissAction: ((UIAlertAction) -> Void)? = nil) {
    weak var vc = viewController
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title,
                                    message: message,
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: dismissAction))
      vc?.present(alert, animated: true)
    }
  }
}

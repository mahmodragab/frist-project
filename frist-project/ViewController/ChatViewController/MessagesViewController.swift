//
//  MessagesViewController.swift
//  frist-project
//
//  Created by abdallah ragab on 09/10/2022.
//

import UIKit

class MessagesViewController: UIViewController {
    var messages: [String] = []

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var chatTxf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.dataSource = self
        messageTableView.delegate = self
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 80
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func sendBtn(_ sender: Any) {
        messages.append(chatTxf.text!)
        messageTableView.reloadData()
        chatTxf.text = ""
        
    }
}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let senderCell = tableView.dequeueReusableCell(withIdentifier: senderMessageCell.reuseIdentifire, for: indexPath) as? senderMessageCell else { fatalError() }
            senderCell.messgeLbl.text = messages[indexPath.row]

            return senderCell
        } else {

            guard let reciveCell = tableView.dequeueReusableCell(withIdentifier: reciverMessageCell.reuseIdentifire, for: indexPath) as? reciverMessageCell else { fatalError() }
            reciveCell.messReciverLbl.text = messages[indexPath.row]
            

            return reciveCell
        }
 
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//
//    }
    
    

}

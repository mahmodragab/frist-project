//
//  ChatViewController.swift
//  frist-project
//
//  Created by abdallah ragab on 07/10/2022.
//

import UIKit

class ChatViewController: UIViewController {

    let names = ["Mahmod", "Abdo", "Medo", "Loash", "Hamoksha", "Yasser", "Yaseen", "Meshmesh", "Mokash"]
    var filter: [String] = []
    
    @IBOutlet weak var searchChat: UISearchBar!
    @IBOutlet weak var chatTableView: UITableView!

    // MARK: - lifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        searchChat.delegate = self
        
        filter = names

    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableViewDataSource -

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: chatCell.reuseIdentifire, for: indexPath) as? chatCell else {fatalError()}
        let data = filter[indexPath.row]
        cell.nameLbl.text = data
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "MessagesViewController") as? MessagesViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - SearchBarDelegate -

extension ChatViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter = []
        if searchText == "" {
            filter = names
        }
        
        for word in names {
            if word.uppercased().contains(searchText.uppercased()){
                filter.append(word)
            }
        }
        self.chatTableView.reloadData()
    }
}

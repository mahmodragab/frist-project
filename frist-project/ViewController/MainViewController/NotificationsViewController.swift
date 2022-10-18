//
//  notificationsVC.swift
//  frist-project
//
//  Created by abdallah ragab on 04/08/2022.
//

import UIKit

class NotificationsViewController: UIViewController {

    // MARK: - IBOutlet -

    @IBOutlet weak var tableView: UITableView!

    // MARK: - LifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
}

// MARK: - Data source and Delegate for table View -

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: notificationCell.reuseIdentifire, for: indexPath) as? notificationCell else { fatalError() }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60

    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section Name"

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

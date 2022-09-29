//
//  MainVC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit
import Alamofire
import SwiftLoader

class MainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource,UITableViewDelegate ,UICollectionViewDelegateFlowLayout {
    
    var model = CreateUserModel()
    let defaults = UserDefaults.standard
    var listofPosts: [Info]? = []
    var listofStatus: [Status]? = []
    
    @IBOutlet weak var LogOutBtn: UIButton!
    @IBOutlet weak var logoLbl: UILabel!
    @IBOutlet weak var recomLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: get user info from userDefault
        // print userINfo data
//        loadUserInfo()
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.collectionViewLayout = configureLayout()
        tableView.dataSource = self
        tableView.delegate = self
    
        //call service
        Posts { [self] response in
            SwiftLoader.show(title: "Loadind...", animated: true)
              switch response {
              case .success(let response):
                  self.listofPosts = response
                  self.tableView.reloadData()
                  SwiftLoader.hide()
                  self.postsEmptyData()
              case .failure(_):
                  AlertMessage.showMessage(message: "There was an error getting posts ", title: "ERORR", on: self)
              }
        }
        
        status { [self] response in
            SwiftLoader.show(title: "Loading...", animated: true)
            switch response {
            case .success(let response):
                self.listofStatus = response
                self.collectionView.reloadData()
                SwiftLoader.hide()
                self.statusEmptyData()
            case .failure(_):
                AlertMessage.showMessage(message: "There was an error getting status", title: "ERROR", on: self)
            }
        }
        
        localization()
    }
    
    func localization() {
        self.LogOutBtn.titleLabel?.text = NSLocalizedString("LogOutBtn", comment: "")
        self.logoLbl.text = NSLocalizedString("logoLbl", comment: "")
        self.recomLbl.text = NSLocalizedString("recomLbl", comment: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func postsEmptyData(){
        if listofPosts?.count == 0 {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                    emptyLabel.text = "No Data"
                    emptyLabel.backgroundColor = UIColor.lightGray
                    emptyLabel.textAlignment = NSTextAlignment.center
                    self.tableView.backgroundView = emptyLabel
                    self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        } else {
            self.tableView.backgroundView = nil
        }
    }
    
    func statusEmptyData(){
        if listofStatus?.count == 0 {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                    emptyLabel.text = "No Data"
                    emptyLabel.backgroundColor = UIColor.darkGray
                    emptyLabel.textAlignment = NSTextAlignment.center
                    self.collectionView.backgroundView = emptyLabel
        } else {
            self.collectionView.backgroundView?.isHidden = true
        }
    }
    
    func loadUserInfo() {
        
        if let savedUser = defaults.object(forKey: "SavedDataResponse") as? Data {
            let decoder = JSONDecoder()
            if let loadedModel = try? decoder.decode(UserInfo.self, from: savedUser) {
                print(loadedModel.cityArabic, loadedModel.firstName , loadedModel.email , loadedModel.districtArabic)
            }
        }
    }
    
    
    
    @IBAction func profileBtn(_ sender: Any) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logOut() {
         UserDefaults.standard.removeObject(forKey: "SavedDataResponse")
        UserDefaults.standard.synchronize()
            
            let storybord = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storybord.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        logOut()
    }
    
    
//    func configureLayout() -> UICollectionViewCompositionalLayout {
//        let sizeItem = NSCollectionLayoutSize(widthDimension: .absolute(90), heightDimension: .absolute(90))
//        let item = NSCollectionLayoutItem(layoutSize: sizeItem)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:0, bottom: 0, trailing: 0)
//        let sizeGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(1))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: sizeGroup, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        return UICollectionViewCompositionalLayout(section: section)
//    }

    
    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func Posts(completion: @escaping (Result<[Info]?, Error>) -> Void) {
        
      let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/posts"
        AF.request(path, method: .get  , headers: ["x-mock-response-code": "200"]).responseDecodable(of: PostInfo.self) { response in
            
        switch response.result {
        case .success(let response):
            completion(.success((response.data)))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
    
    func status(completion: @escaping (Result<[Status]?, Error>) -> Void) {
        
        let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/status"
        AF.request(path, method: .get , headers: ["x-mock-response-code1": "200"]).responseDecodable(of: StatusInfo.self) { response in
            
            switch response.result {
            case .success(let response):
                completion(.success((response.data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: - Data source for collection View -

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return listofStatus?.count ?? 0
         
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storyCell.reuseIdentifire, for: indexPath) as? storyCell else { fatalError() }
         let model = listofStatus?[indexPath.row]
         cell.storyNameLbl.text = model?.userFullname
         cell.storyImage.loadFrom(URLAddress: model?.img ?? "")
         cell.storyImage?.makeRounded()
         return cell
     }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
//    {
//        guard let cell = cell as? storyCell else
//        {
//            return
//        }
//
////         let cellHeight : CGFloat = cell.frame.size.height
////        let labelHeight : CGFloat = cell.storyNameLbl?.frame.size.height ?? 0.0
//        cell.storyImage?.makeRounded()
//    }
    
    
    
    // MARK: - Data source for table View -

    func numberOfSections(in tableView: UITableView) -> Int {
       1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
            return listofPosts?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseidentifire, for: indexPath) as? TableViewCell else { fatalError() }
        let model =  listofPosts?[indexPath.row]
        cell.imagge.loadFrom(URLAddress: model?.img ?? "" )
        cell.nameLbl.text = model?.userFullname
        cell.locationLbl.text = model?.fullAddress
        cell.timeLbl.text = convertDateFormater(date: model?.date ?? "")
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 
    }
    
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: date) else {
//            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }

}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async {
            [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}

extension UIImageView {
    
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}

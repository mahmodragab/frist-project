//
//  MainVC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit
import Alamofire
import SwiftLoader


class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {



    // MARK: - IBOutlet -

    @IBOutlet weak var LogOutBtn: UIButton!
    @IBOutlet weak var logoLbl: UILabel!
    @IBOutlet weak var recomLbl: UILabel!

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Variables -

    var model = CreateUserModel()
    let defaults = UserDefaults.standard
    var listofPosts = Box<[Info]?>(value: [])

//    var listofPosts: [Info]? = []
    var listofStatus: [Status]? = []
    var viewModel = MainViewModel()

    // MARK: - LifeCycle -

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.posts()
        viewModel.status()
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        listofPosts.bind { list in
            self.tableView.reloadData()
        }

        collectionView.dataSource = self
        collectionView.delegate = self

        tableView.dataSource = self
        tableView.delegate = self

        
        viewModel.postsResponse.bind { response in
            if let post = response {
                SwiftLoader.show(title: "Loading...", animated: true)
                self.listofPosts.value = post
                self.tableView.reloadData()
                SwiftLoader.hide()
                self.postsEmptyData()
            } else {
                SwiftLoader.hide()
                AlertMessage.showMessage(message: "There was an error getting posts ", title: "ERORR", on: self)
            }
        }
        
        viewModel.statusResponse.bind { response in
            if let status = response {
                SwiftLoader.show(title: "Loading...", animated: true)
                self.listofStatus = status
                self.collectionView.reloadData()
                SwiftLoader.hide()
                self.statusEmptyData()
            } else {
                SwiftLoader.hide()
                AlertMessage.showMessage(message: "There was an error getting status", title: "ERROR", on: self)
            }
        }
        

        setlocalization()
    }


    // MARK: - IBAction -

    @IBAction func profileBtn(_ sender: Any) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func logOutBtn(_ sender: Any) {
        logOut()
    }

    @IBAction func BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

    // MARK: - Data source for table View -

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listofPosts.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedModel = listofPosts.value?[indexPath.row] else { return }
//        let downloadImg = downloadImg(url: selectedModel.img ?? "")
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example

        let currentCell = tableView.cellForRow(at: indexPath!) as? TableViewCell


        let fileURL = NSURL(fileURLWithPath: (currentCell?.model?.img)!)
        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)

    }

    func downloadImg(url: String) {
        let remoteImageURL = URL(string: url)!

        // Use Alamofire to download the image
        AF.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                print(response.result)

                // Show the downloaded image:
                if let data = response.data {
                    self.saveImage(imgData: data)
                }
            }
        }
    }



    func saveImage(imgData: Data) {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else { return }
        do {

            let fileURL = try imgData.write(to: directory.appendingPathComponent("fileName.png")!)


        } catch {
            print(error.localizedDescription)
        }
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseidentifire, for: indexPath) as? TableViewCell else { fatalError() }
        let model = listofPosts.value?[indexPath.row]
        cell.bindData(model: model, delegate: self)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//MARK: - Extensions UIImageView -

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
    
    func makeCurved() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 8
        layer.cornerRadius = self.frame.width / 8
        clipsToBounds = true
    }
}

//MARK: - Helpers Functions -

extension MainViewController {

    func logOut() {
        UserDefaults.standard.removeObject(forKey: "SavedDataResponse")
        UserDefaults.standard.synchronize()

        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)

    }

    func setlocalization() {
        self.LogOutBtn.setTitle(NSLocalizedString("LogOutBtn", comment: ""), for: .normal)
        self.logoLbl.text = NSLocalizedString("logoLbl", comment: "")
        self.recomLbl.text = NSLocalizedString("recomLbl", comment: "")
    }

    func postsEmptyData() {
        if listofPosts.value?.count == 0 {
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

    func statusEmptyData() {
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
                print(loadedModel.cityArabic, loadedModel.firstName, loadedModel.email, loadedModel.districtArabic)
            }
        }
    }


}


extension MainViewController: TableViewCellDelegate {
    func deleteBtn(model: Info?) {
        print("delete btn action \(model)")
//        viewModel.delete(model: model)
    }


}

//MARK: - Network layer -

extension MainViewController {

//    func Posts(completion: @escaping (Result<[Info]?, Error>) -> Void) {
//        let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/posts"
//        AF.request(path, method: .get, headers: ["x-mock-response-code": "200"]).responseDecodable(of: PostInfo.self) { response in
//
//            switch response.result {
//            case .success(let response):
//                completion(.success((response.data)))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    func status(completion: @escaping (Result<[Status]?, Error>) -> Void) {
//        let path = "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io/status"
//        AF.request(path, method: .get, headers: ["x-mock-response-code1": "200"]).responseDecodable(of: StatusInfo.self) { response in
//
//            switch response.result {
//            case .success(let response):
//                completion(.success((response.data)))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }

}
//        AuthManagerForPosts.shared.Posts { response in
//            if (response != nil) {
//                SwiftLoader.show(title: "Loading...", animated: true)
//                self.listofPosts.value = response
//                self.tableView.reloadData()
//                SwiftLoader.hide()
//                self.postsEmptyData()
//            } else {
//                SwiftLoader.hide()
//                AlertMessage.showMessage(message: "There was an error getting posts ", title: "ERORR", on: self)
//            }
//        }

//        AuthManagerForPosts.shared.status { response in
//            if (response != nil) {
//                SwiftLoader.show(title: "Loading...", animated: true)
//                self.listofStatus = response
//                self.collectionView.reloadData()
//                SwiftLoader.hide()
//                self.statusEmptyData()
//            } else {
//                SwiftLoader.hide()
//                AlertMessage.showMessage(message: "There was an error getting status", title: "ERROR", on: self)
//            }
//        }
//        Posts { [self] response in
//            SwiftLoader.show(title: "Loadind...", animated: true)
//            switch response {
//            case .success(let response):
//                self.listofPosts.value = response
//                self.tableView.reloadData()
//                SwiftLoader.hide()
//                self.postsEmptyData()
//            case .failure(_):
//                SwiftLoader.hide()
//                AlertMessage.showMessage(message: "There was an error getting posts ", title: "ERORR", on: self)
//            }
//        }
//
//        status { [self] response in
//            SwiftLoader.show(title: "Loading...", animated: true)
//            switch response {
//            case .success(let response):
//                self.listofStatus = response
//                self.collectionView.reloadData()
//                SwiftLoader.hide()
//                self.statusEmptyData()
//            case .failure(_):
//                SwiftLoader.hide()
//                AlertMessage.showMessage(message: "There was an error getting status", title: "ERROR", on: self)
//            }
//        }

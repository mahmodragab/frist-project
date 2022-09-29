//
//  profileVC.swift
//  frist-project
//
//  Created by abdallah ragab on 03/08/2022.
//

import UIKit

class ProfileViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnChangeLanguage: friendRequestBtn!
    
    // MARK: - LifeCycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentLang =  LanguageManager.language == .ar  ? "arabic"  :  "english"
        btnChangeLanguage.setTitle(currentLang , for: .normal)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setlayout()
    }
    
    // MARK: - IBAction -
    
    @IBAction func changeLanguageTapped(_ sender: UIButton) {
        if LanguageManager.language == .en {
            LanguageManager.changeLanguage(lang: .ar)
            showMainViewController()
        }else  {
            LanguageManager.changeLanguage(lang: .en)
            showMainViewController()
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Data source for collection View -
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalPhotoCell.reuseIdentifire, for: indexPath) as? personalPhotoCell else { fatalError() }
        return cell
    }
    
}

// MARK: - DynamicCollectionView -

class DynamicCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

//MARK: - Helpers Functions -

extension ProfileViewController {
    
    func showMainViewController(){
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        guard let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
        sceneDelegate.window!.rootViewController = UINavigationController(rootViewController: rootController)
    }
    
    func setlayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            collectionView!.collectionViewLayout = layout
    }
    
}

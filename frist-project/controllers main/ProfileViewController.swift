//
//  profileVC.swift
//  frist-project
//
//  Created by abdallah ragab on 03/08/2022.
//

import UIKit

class ProfileViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: width / 3, height: width / 3)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            collectionView!.collectionViewLayout = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    func configureLayout() -> UICollectionViewCompositionalLayout {
//        let sizeItem = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
//           let item = NSCollectionLayoutItem(layoutSize: sizeItem)
//           item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:0, bottom: 0, trailing: 0)
//           let sizeGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(1))
//           let group = NSCollectionLayoutGroup.horizontal(layoutSize: sizeGroup, subitems: [item])
//           let section = NSCollectionLayoutSection(group: group)
//           return UICollectionViewCompositionalLayout(section: section)
//       }

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

//
//  profileVC.swift
//  frist-project
//
//  Created by abdallah ragab on 03/08/2022.
//

import UIKit

class profileVC: UIViewController , UICollectionViewDataSource {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Data source for collection View -

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalPhotoCell.reuseIdentifire, for: indexPath) as? personalPhotoCell else { fatalError() }
        return cell
    }
    
}

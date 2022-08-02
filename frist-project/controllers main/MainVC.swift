//
//  MainVC.swift
//  frist-project
//
//  Created by abdallah ragab on 31/07/2022.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDataSource, UITableViewDataSource,UITableViewDelegate ,UICollectionViewDelegateFlowLayout {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
//        collectionView.collectionViewLayout = configureLayout()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let sizeItem = NSCollectionLayoutSize(widthDimension: .absolute(90), heightDimension: .absolute(90))
        let item = NSCollectionLayoutItem(layoutSize: sizeItem)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:0, bottom: 0, trailing: 0)
        let sizeGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: sizeGroup, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

  
    // MARK: - Data source for collection View -

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         7
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storyCell.reuseIdentifire, for: indexPath) as? storyCell else { fatalError() }
//         cell.storyBtn.titleLabel?.text = "abdallah"
         
         
         return cell
     }
    
    // MARK: - Data source for table View -

    func numberOfSections(in tableView: UITableView) -> Int {
       1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseidentifire, for: indexPath) as? TableViewCell else { fatalError() }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 
    }
}

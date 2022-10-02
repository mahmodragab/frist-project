//
//  SearchViewController.swift
//  frist-project
//
//  Created by abdallah ragab on 01/10/2022.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    // MARK: - Variables -

    let data = ["Mahmod", "Abdallah", "Ahmed", "Youssef", "Leen", "Elsayed", "Omar"]
    var filterData: [String]!

    // MARK: - IBOutlet -

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData = data
        searchCollectionView.dataSource = self
        searchBar.delegate = self
    }
    
}

// MARK: - CollectionViewDataSource -

extension SearchViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewCell.reuseIdentifire, for: indexPath) as? searchCollectionViewCell else {fatalError()}
        cell.nameSearchLbl.text = filterData[indexPath.row]
        cell.searchImg.makeCurved()
        
        return cell
    }
}

// MARK: - SearchBarDelegate -

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchText == "" {
            filterData = data
        }
        
        for word in data {
            if word.uppercased().contains(searchText.uppercased()){
                filterData.append(word)
            }
        }
        self.searchCollectionView.reloadData()
    }
}

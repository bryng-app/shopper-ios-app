//
//  AllStoresController.swift
//  bryng
//
//  Created by Florian Woelki on 30.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class AllStoresController: BaseViewController, UICollectionViewDelegateFlowLayout /* UISearchBarDelegate */ {
    
    //fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    
    fileprivate var allStores = [Store]()
    fileprivate let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        fetchAllStores()
        
        collectionView.backgroundColor = .modernGray
        
        collectionView.register(CloseHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(AllStoresCell.self, forCellWithReuseIdentifier: cellId)
        
        setupSearchBar()
    }
    
    fileprivate func fetchAllStores() {
        let allStoresQuery = AllStoresQuery()
        GraphQL.shared.apollo.fetch(query: allStoresQuery) { result, error in
            if let error = error {
                print("Something went wrong while fetching all stores. \(error)")
                return
            }
            
            guard let allStores = result?.data?.allStores else { return }
            
            for storeData in allStores {
                let store = Store(name: storeData.name, logo: storeData.logo, openingHours: storeData.openingHours, longitude: storeData.location.longitude, latitude: storeData.location.latitude)
                self.allStores.append(store)
            }
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    fileprivate func setupSearchBar() {
        /*definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self*/
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 24, left: 0, bottom: 24, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allStores.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AllStoresCell
        
        cell.store = allStores[indexPath.row]
        
        // TODO: Set parsed data
        cell.didSelectHandler = { [weak self] storeName in
            self?.goToStoreController(name: storeName)
        }
        
        return cell
    }
    
    func goToStoreController(name: String) {
        let storeController = StoreController()
        storeController.storeName = name
        navigationController?.pushViewController(storeController, animated: true)
    }
    
    /*func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }*/
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let closeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CloseHeaderView
        closeHeaderView.titleLabel.text = "Geschäfte"
        closeHeaderView.closeButton.isHidden = true
        closeHeaderView.backgroundColor = .modernGray
        
        return closeHeaderView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
}

//
//  NewCartController.swift
//  bryng
//
//  Created by Florian Woelki on 17.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class CartController: UITableViewController {

    private var cartProducts = [CartProduct]()
    private let cellId = "cellId"
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.fillSuperview()
        fetchCartProducts()
        
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        
        tableView.register(CartCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func fetchCartProducts() {
        CoreDataManager.shared.getCartItems { [weak self] (storeItems) in
            var cartProductsDict = [CartProduct: Int]()
            
            for storeItem in storeItems {
                let cartProduct = CartProduct(id: storeItem.id, name: storeItem.name, amount: 0, price: storeItem.price, image: storeItem.image)
                
                if let value = cartProductsDict[cartProduct] {
                    cartProductsDict[cartProduct] = value + 1
                } else {
                    cartProductsDict[cartProduct] = 1
                }
            }
            
            for (cartProduct, amount) in cartProductsDict {
                let cartProduct = CartProduct(id: cartProduct.id, name: cartProduct.name, amount: amount, price: cartProduct.price, image: cartProduct.image == "" ? nil : cartProduct.image)
                self?.cartProducts.append(cartProduct)
            }
            
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = UIRectEdge.bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        extendedLayoutIncludesOpaqueBars = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CartCell
        
        cell.cartProduct = cartProducts[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CartHeader()
        
        headerView.handleDismiss = { [weak self] in
            let transition: CATransition = CATransition()
            transition.duration = 0.35
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromBottom
            self?.navigationController!.view.layer.add(transition, forKey: kCATransition)
            self?.navigationController?.popViewController(animated: false)
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Löschen") { (action, indexPath) in
            CoreDataManager.shared.removeCartItem(id: self.cartProducts[indexPath.row].id, completly: true)
            self.cartProducts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
    
}

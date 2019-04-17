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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartProducts = [
            CartProduct(name: "Apfel", amount: 3),
            CartProduct(name: "Manderine", amount: 2),
            CartProduct(name: "Banane", amount: 8)
        ]
        
        tableView.backgroundColor = .modernGray
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        
        tableView.register(CartCell.self, forCellReuseIdentifier: cellId)
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
            self?.dismiss(animated: true, completion: nil)
        }
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Löschen") { (action, indexPath) in
            self.cartProducts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
    
}

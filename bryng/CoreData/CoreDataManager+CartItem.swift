//
//  CoreDataManager+CartItem.swift
//  bryng
//
//  Created by Florian Woelki on 28.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func addCartItem(id: String) {
        let context = persistentContainer.viewContext
        
        let cartItem = NSEntityDescription.insertNewObject(forEntityName: "CartItem", into: context)
        cartItem.setValue(id, forKey: "id")
        
        do {
            try context.save()
        } catch {
            print("Something went wrong while saving cart item with id \(id): \(error)")
        }
    }
    
    func getAmountOfCartItems() -> Int {
        let context = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        
        do {
            let result = try context.fetch(request)
            
            return result.count
        } catch {
            print("Something went wrong while getting the size of cart items. \(error)")
        }
        
        return 0
    }
    
    func getTotalCartItemsPrice(callback: @escaping ((_ total: Double) -> ())) {
        getCartItems { (storeItems) in
            var total = 0.0
            for storeItem in storeItems {
                total += storeItem.price
            }
            
            callback(total)
        }
    }
    
    func getCartItems(callback: @escaping ((_ cartItems: [StoreItem]) -> ())) {
        let context = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        
        do {
            let semaphore = DispatchSemaphore(value: 0)
            let dispatchQueue = DispatchQueue.global(qos: .background)
            
            let coreDataResult = try context.fetch(request)
            var cartItems = [StoreItem]()
            
            dispatchQueue.async {
                for data in coreDataResult as! [NSManagedObject] {
                    guard let cartItemId = data.value(forKey: "id") as? String else { continue }
                    
                    let getProductQuery = GetProductQuery(id: cartItemId)
                    
                    GraphQL.shared.apollo.fetch(query: getProductQuery) { result, error in
                        if let error = error {
                            print("Something went wrong while getting a product with the id \(cartItemId): \(error)")
                            return
                        }
                        
                        guard let product = result?.data?.getProduct else { return }
                        
                        let cartItem = StoreItem(id: product.id, name: product.name, image: product.image, price: product.price, weight: product.weight, storeName: product.storeName, categoryName: product.categoryName)
                        
                        cartItems.append(cartItem)
                        semaphore.signal()
                    }
                
                    semaphore.wait()
                }
                
                DispatchQueue.main.async {
                    callback(cartItems)
                }
            }
            
        } catch {
            print("Something went wrong while fetching cart items array! \(error)")
        }
    }
    
    func removeCartItem(id: String, completly: Bool = false) {
        let context = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        
        do {
            let results = try context.fetch(request)
            for data in results {
                guard let objectData = data as? NSManagedObject else { continue }
                if objectData.value(forKey: "id") as? String == id {
                    context.delete(objectData)
                    if !completly {
                        break
                    }
                }
            }
        } catch {
            print("Something went wrong while deleting item \(id): \(error)")
        }
        
        do {
            try context.save()
        } catch {
            print("Something went wrong while saving in 'removeCartItem': \(error)")
        }
    }
    
    func removeAllCartItems() {
        let context = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            for data in results {
                guard let objectData = data as? NSManagedObject else { continue }
                context.delete(objectData)
            }
        } catch {
            print("Something went wrong while deleting all cart items! \(error)")
        }
        
        do {
            try context.save()
        } catch {
            print("Something went wrong while saving in 'removeAllCartItem': \(error)")
        }
    }
    
}

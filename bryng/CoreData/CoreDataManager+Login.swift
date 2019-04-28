//
//  CoreDataManager+Login.swift
//  bryng
//
//  Created by Florian Woelki on 28.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func isLoggedIn() -> Bool {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginSession")
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                return result.value(forKey: "token") != nil
            }
        } catch {
            print("Failed to fetch Login Session. \(error)")
        }
        
        return false
    }
    
    func isFirstLogin() -> Bool {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginSession")
        
        do {
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                return result.value(forKey: "firstLogin") as! Bool
            }
        } catch {
            print("Failed to fetch login session. \(error)")
        }
        
        return true
    }
    
    func setFirstLogin() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let loginSession = NSEntityDescription.insertNewObject(forEntityName: "LoginSession", into: context)
        loginSession.setValue(false, forKey: "firstLogin")
        
        do {
            try context.save()
        } catch {
            print("Fetch failed: \(error)")
        }
    }
    
    func getLoginToken() -> String? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginSession")
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let token = data.value(forKey: "token") {
                    return token as? String
                }
            }
        } catch {
            print("Failed to fetch login session data. \(error)")
        }
        
        return nil
    }
    
    func updateLoginSession(token: String?) {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        
        // Check if LoginSession exists
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginSession")
        var entitiesCount = 0
        
        guard let token = token else {
            // Remove token
            if let result = try? viewContext.fetch(fetchRequest) {
                for object in result as! [NSManagedObject] {
                    object.setValue(nil, forKey: "token")
                }
            }
            
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("Could not save Login Session. \(error)")
            }
            return
        }
        
        do {
            entitiesCount = try viewContext.count(for: fetchRequest)
        } catch {
            print("Error executing fetch request: \(error)")
        }
        
        if entitiesCount > 0 { // if login session exists
            fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginSession")
            
            do {
                let results = try viewContext.fetch(fetchRequest) as? [NSManagedObject]
                if results?.count != 0 {
                    results![0].setValue(token, forKey: "token")
                }
            } catch {
                print("Fetch failed: \(error)")
            }
        } else {
            let loginSession = NSEntityDescription.insertNewObject(forEntityName: "LoginSession", into: viewContext)
            loginSession.setValue(token, forKey: "token")
        }
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save Login Session. \(error)")
        }
    }

    
}

//
// Created by Florian Woelki on 2019-04-12.
// Copyright (c) 2019 bryng. All rights reserved.
//

import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "bryng")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        return container
    }()
    
    func isLoggedIn() -> Bool {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginSession")
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                return result.value(forKey: "isLoggedIn") as! Bool
            }
        } catch {
            print("Failed to fetch Login Session. \(error)")
        }
        
        return false
    }
    
    func updateLoginSession(isLoggedIn: Bool) {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        
        // Check if LoginSession exists
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginSession")
        var entitiesCount = 0
        
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
                    results![0].setValue(isLoggedIn, forKey: "isLoggedIn")
                }
            } catch {
                print("Fetch failed: \(error)")
            }
        } else {
            let loginSession = NSEntityDescription.insertNewObject(forEntityName: "LoginSession", into: viewContext)
            loginSession.setValue(isLoggedIn, forKey: "isLoggedIn")
        }
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save Login Session. \(error)")
        }
    }

}

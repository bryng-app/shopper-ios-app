//
// Created by Florian Woelki on 2019-04-12.
// Copyright (c) 2019 bryng. All rights reserved.
//

import CoreData

struct CoreDataManager {

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

}

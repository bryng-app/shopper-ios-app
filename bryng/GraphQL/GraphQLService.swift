//
//  GraphQLService.swift
//  bryng
//
//  Created by Florian Woelki on 20.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import Foundation

class GraphQLService {
    
    static let shared = GraphQLService()
    
    func fetchAllStores(completion: @escaping ((_ stores: [Store]) -> ())) {
        let allStoresQuery = AllStoresQuery()
        GraphQL.shared.apollo.fetch(query: allStoresQuery) { result, error in
            if let error = error {
                print("Something went wrong while fetching all stores. \(error)")
                return
            }
            
            guard let allStores = result?.data?.allStores else { return }
            
            var stores = [Store]()
            
            for storeData in allStores {
                let store = Store(name: storeData.name, logo: storeData.logo, openingHours: storeData.openingHours, longitude: storeData.location.longitude, latitude: storeData.location.latitude)
                stores.append(store)
            }
            
            completion(stores)
        }
    }
    
}

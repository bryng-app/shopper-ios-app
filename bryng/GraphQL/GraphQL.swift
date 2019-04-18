//
//  GraphQL.swift
//  bryng
//
//  Created by Florian Woelki on 18.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import Apollo

class GraphQL {
    
    static let shared = GraphQL()
    
    let apollo = ApolloClient(url: URL(string: "http://localhost:8080/graphql")!)
    
}

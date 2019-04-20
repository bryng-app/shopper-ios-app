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
    
    let graphQLUrl = "http://localhost:8080/graphql"
    lazy var apollo = ApolloClient(url: URL(string: graphQLUrl)!)
    
    func getAuthorizedApollo(token: String?, callback: @escaping ((_ client: ApolloClient) -> ())) {
        let loginToken = CoreDataManager.shared.getLoginToken()
        
        if let loginToken = loginToken {
            if let token = token {
                let configuration = URLSessionConfiguration.default
                configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
                
                let url = URL(string: GraphQL.shared.graphQLUrl)!
                let apollo = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
                callback(apollo)
            } else {
                generateJWTToken(loginToken: loginToken) { (jwtToken) in
                    guard let jwtToken = jwtToken else {
                        print("Could not generate jwt token!")
                        return
                    }
                    
                    let configuration = URLSessionConfiguration.default
                    configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(jwtToken)"]
                    
                    let url = URL(string: GraphQL.shared.graphQLUrl)!
                    let apollo = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
                    callback(apollo)
                }
            }
        }
    }
    
    private func generateJWTToken(loginToken: String, callback: @escaping ((_ jwtToken: String?) -> ())) {
        let getJWTTokenMutation = GetJwtTokenMutation(loginToken: loginToken)
        
        apollo.perform(mutation: getJWTTokenMutation) { result, error in
            if let error = error {
                print("Something went wrong while getting jwt token. \(error)")
                callback(nil)
                return
            }
            
            guard let getJwtToken = result?.data?.getJwtToken else {
                callback(nil)
                return
            }
            
            callback(getJwtToken.token)
        }
    }
    
}

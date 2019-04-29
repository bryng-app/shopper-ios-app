//
//  Product.swift
//  bryng
//
//  Created by Florian Woelki on 17.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import Foundation

struct CartProduct : Hashable {
    
    let id: String
    let name: String
    var amount: Int
    let price: Double
    let image: String?
    
}

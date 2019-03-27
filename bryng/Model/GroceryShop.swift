//
//  GroceryShop.swift
//  bryng
//
//  Created by Florian Woelki on 27.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import MapKit

class GroceryShop: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
}

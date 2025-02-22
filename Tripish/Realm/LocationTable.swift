//
//  LocationTable.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/11.
//

import Foundation
import RealmSwift

class LocationTable: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var placeName: String
    @Persisted var latitude: Double
    @Persisted var longitude: Double
    
    convenience init(id: String, placeName: String, latitude: Double, longitude: Double) {
        
        self.init()
        
        self.id = id
        self.placeName = placeName
        self.latitude = latitude
        self.longitude = longitude
    }
}

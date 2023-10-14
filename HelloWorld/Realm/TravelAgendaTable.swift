//
//  TravelAgendaTable.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/03.
//

import RealmSwift
//import UIKit
import MapKit

class TravelAgendaTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var memo: String?
    @Persisted var numberOfImages: Int
    
//    @Persisted var toDoList : List<TodoTable> = List<TodoTable>()
//    @Persisted var costList : List<CostTable> = List<CostTable>()
//    @Persisted var linkList : List<LinkTable> = List<LinkTable>()
    
    @Persisted var placeName: String?
    @Persisted var latitude: CLLocationDegrees?
    @Persisted var longitude: CLLocationDegrees?
    
    convenience init(title: String, startDate: Date, endDate: Date, memo: String? = nil, numberOfImages: Int, placeName: String?, latitude: CLLocationDegrees?, longitude: CLLocationDegrees?) {
        
        self.init()
        
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.memo = memo
        self.numberOfImages = numberOfImages
        
//        self.toDoList = toDoList
//        self.costList = costList
//        self.linkList = linkList
        
        self.placeName = placeName
        self.latitude = latitude
        self.longitude = longitude
    }
}


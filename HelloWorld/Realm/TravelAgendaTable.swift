//
//  TravelAgendaTable.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/03.
//

import RealmSwift
import UIKit

class TravelAgendaTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var memo: String?
    @Persisted var numberOfImages: Int
    
    @Persisted var toDoList : List<ToDoObject> = List<ToDoObject>()
    @Persisted var costList : List<CostObject> = List<CostObject>()
    @Persisted var linkList : List<LinkObject> = List<LinkObject>()
    
    convenience init(title: String, startDate: Date, endDate: Date, memo: String? = nil, numberOfImages: Int, toDoList: List<ToDoObject>, costList: List<CostObject>, linkList: List<LinkObject>) {
        
        self.init()
        
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.memo = memo
        self.numberOfImages = numberOfImages
        
        self.toDoList = toDoList
        self.costList = costList
        self.linkList = linkList
    }
}

class ToDoObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var toDo: String
    
    convenience init(toDo: String) {
        self.init()
        self.toDo = toDo
    }

}

class CostObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var cost: String
    
    convenience init(cost: String) {
        self.init()
        self.cost = cost
    }
}

class LinkObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var link: String
    
    convenience init(link: String) {
        self.init()
        self.link = link
    }
}


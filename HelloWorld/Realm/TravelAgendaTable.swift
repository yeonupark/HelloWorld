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
    @Persisted var date: String
    
    @Persisted var memo: String?
    
    var toDoList : List<ToDoObject>?
    var costList : List<CostObject>?
    var linkList : List<LinkObject>?
    
    convenience init(_id: ObjectId, title: String, date: String, memo: String? = nil, toDoList: List<ToDoObject>? = nil, costList: List<CostObject>? = nil, linkList: List<LinkObject>? = nil) {
        
        self.init()
        
        self._id = _id
        self.title = title
        self.date = date
        self.memo = memo
        self.toDoList = toDoList
        self.costList = costList
        self.linkList = linkList
    }
}

class ToDoObject: Object {
    @Persisted var toDo: String
}

class CostObject: Object {
    @Persisted var cost: String
}

class LinkObject: Object {
    @Persisted var link: String
}


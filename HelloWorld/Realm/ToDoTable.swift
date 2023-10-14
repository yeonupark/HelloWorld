//
//  TodoTable.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/14.
//

import Foundation
import RealmSwift

class ToDoTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var agendaID: String
    @Persisted var toDo: String
    
    convenience init(agendaID: String, toDo: String) {
        self.init()
        
        self.agendaID = agendaID
        self.toDo = toDo
    }

}

class CostTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var agendaID: String
    @Persisted var cost: String
    
    convenience init(agendaID: String, cost: String) {
        self.init()
        
        self.agendaID = agendaID
        self.cost = cost
        
    }
}

class LinkTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var agendaID: String
    @Persisted var link: String
    
    convenience init(agendaID: String, link: String) {
        self.init()
        
        self.agendaID = agendaID
        self.link = link
    }
}

//
//  InnerTableRepository.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/14.
//

import Foundation
import RealmSwift

protocol ToDoTableRepositoryType: AnyObject {
    
    func fetch() -> Results<ToDoTable>
    func addItem(_ item: ToDoTable)
    func deleteItemFromID(_ agendaID: String)
}

class ToDoTableRepository: ToDoTableRepositoryType {
    
    private let realm = try! Realm()
    
    func fetch() -> RealmSwift.Results<ToDoTable> {
        let data = realm.objects(ToDoTable.self)
        return data
    }
    
    func addItem(_ item: ToDoTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        }
        catch {
            print(error)
        }
    }
    
    func deleteItemFromID(_ agendaID: String) {
        let data = realm.objects(ToDoTable.self)
        for item in data {
            if item.agendaID == agendaID {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

class CostTableRepository{
    
    private let realm = try! Realm()
    
    func fetch() -> RealmSwift.Results<CostTable> {
        let data = realm.objects(CostTable.self)
        return data
    }
    
    func addItem(_ item: CostTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        }
        catch {
            print(error)
        }
    }
    
    func deleteItemFromID(_ agendaID: String) {
        let data = realm.objects(CostTable.self)
        for item in data {
            if item.agendaID == agendaID {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

class LinkTableRepository{
    
    private let realm = try! Realm()
    
    func fetch() -> RealmSwift.Results<LinkTable> {
        let data = realm.objects(LinkTable.self)
        return data
    }
    
    func addItem(_ item: LinkTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        }
        catch {
            print(error)
        }
    }
    
    func deleteItemFromID(_ agendaID: String) {
        let data = realm.objects(LinkTable.self)
        for item in data {
            if item.agendaID == agendaID {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

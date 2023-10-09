//
//  TravelAgendaTableRepository.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/05.
//

import Foundation
import RealmSwift

protocol TravelAgendaTableRepositoryType: AnyObject {
    func checkSchemaVersion()
    func fetch() -> Results<TravelAgendaTable>
    func addItem(_ item: TravelAgendaTable)
    func deleteItem(_ item: TravelAgendaTable)
}

class TravelAgendaTableRepository: TravelAgendaTableRepositoryType {
    
    private let realm = try! Realm()
    
    func printRealmLocation() {
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func fetch() -> RealmSwift.Results<TravelAgendaTable> {
        let data = realm.objects(TravelAgendaTable.self).sorted(by: ["startDate", "endDate"])
        return data
    }
    
    func addItem(_ item: TravelAgendaTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        }
        catch {
            print(error)
        }
    }
    
    func deleteItem(_ item: TravelAgendaTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        }
        catch {
            print(error)
        }
    }
    
    func updateItem(id: RealmSwift.ObjectId, title: String, startDate: Date, endDate: Date, memo: String, numberOfImages: Int, toDoList: List<ToDoObject>, costList: List<CostObject>, linkList: List<LinkObject>) {
        
        do {
            try realm.write {
                realm.create(TravelAgendaTable.self, value: ["_id" : id, "title": title, "startDate": startDate, "endDate": endDate, "memo": memo, "numberOfImages": numberOfImages, "toDoList": toDoList, "costList": costList, "linkList": linkList], update: .modified)
            }
        }
        catch {
            print(error)
        }
    }
    
}

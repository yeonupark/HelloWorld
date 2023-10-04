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
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func fetch() -> RealmSwift.Results<TravelAgendaTable> {
        let data = realm.objects(TravelAgendaTable.self)
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
    
}

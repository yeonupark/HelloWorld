//
//  LocationTableRepository.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/11.
//

import Foundation
import RealmSwift

protocol LocationTableRepositoryType: AnyObject {
    
    func checkSchemaVersion()
    func fetch() -> Results<LocationTable>
    func addItem(_ item: LocationTable)
    func deleteItemFromID(_ id: String)
}

class LocationTableRepository: LocationTableRepositoryType {
    
    private let realm = try! Realm()
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func fetch() -> RealmSwift.Results<LocationTable> {
        
        let data = realm.objects(LocationTable.self)
        return data
    }
    
    func addItem(_ item: LocationTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        }
        catch {
            print(error)
        }
    }
    
    func deleteItemFromID(_ id: String) {
        
        let data = realm.objects(LocationTable.self)
        
        for item in data {
            if item.id == id {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                    return
                }
                catch {
                    print(error)
                }
            }
        }
    }
    
    func updateItem(id: String, placeName: String, latitude: Double, longitude: Double) {
        do {
            try realm.write {
                let update = LocationTable(id: id, placeName: placeName, latitude: latitude, longitude: longitude)
                realm.add(update, update: .modified)
            }
        }
        catch {
            print(error)
        }
    }
}

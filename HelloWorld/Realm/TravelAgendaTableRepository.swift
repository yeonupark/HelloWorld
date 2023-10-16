//
//  TravelAgendaTableRepository.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/05.
//

import Foundation
import RealmSwift
import MapKit

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
    
    func updateItem(id: RealmSwift.ObjectId, title: String, startDate: Date, endDate: Date, memo: String, numberOfImages: Int, placeName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        do {
            try realm.write {
                realm.create(TravelAgendaTable.self, value: ["_id" : id, "title": title, "startDate": startDate, "endDate": endDate, "memo": memo, "numberOfImages": numberOfImages, "placeName": placeName, "latitude": latitude, "longitude": longitude], update: .modified)
            }
        }
        catch {
            print(error)
        }
    }
    
    func updateNumberOfImages(id: RealmSwift.ObjectId, numberOfImages: Int) {
        
        do {
            try realm.write {
                realm.create(TravelAgendaTable.self, value: ["_id" : id, "numberOfImages" : numberOfImages], update: .modified)
            }
        }
        catch {
            print(error)
        }
    }
}

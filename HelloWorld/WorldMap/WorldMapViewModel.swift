//
//  WorldMapViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/11.
//

import Foundation
import RealmSwift

class WorldMapViewModel {
    
    var myLocations: Observable<Results<LocationTable>> = Observable(LocationTableRepository().fetch())
}

//
//  WorldMapViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/11.
//

import Foundation
import RealmSwift

class WorldMapViewModel {
    
    var myTravelAgendas: Observable<Results<LocationTable>> = Observable(LocationTableRepository().fetch())
}

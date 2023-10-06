//
//  MyTravelViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/06.
//

import Foundation
import RealmSwift

class MyTravelViewModel {
    
    var myTravelAgendas: Observable<Results<TravelAgendaTable>> = Observable(TravelAgendaTableRepository().fetch())
    
    var isEditable: Observable<Bool> = Observable(false)
    
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let result = dateFormatter.string(from: date)
        
        return result
    }

}

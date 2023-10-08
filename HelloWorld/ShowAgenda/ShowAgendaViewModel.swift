//
//  ShowAgendaViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/08.
//

import Foundation
import UIKit

class ShowAgendaViewModel {
    
    var isEditable: Observable<Bool> = Observable(false)
    var travelAgendaTable = TravelAgendaTable()
    
    var toDoList: Observable<[String]> = Observable([])
    var costList: Observable<[String]> = Observable([])
    var linkList: Observable<[String]> = Observable([])
    var memoText: Observable<String> = Observable("")
    
    var dateList: Observable<[Date]> = Observable([])
    
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let result = dateFormatter.string(from: date)
        
        return result
    }
}

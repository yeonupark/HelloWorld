//
//  AddNewAgendaViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import Foundation
import UIKit
import RealmSwift

enum Section: CaseIterable {
    case MemoText
    case ToDoList
    case CostList
    case LinkList

    var localizedString: String {
        switch self {
        case .MemoText:
            return NSLocalizedString("agendaSection_memo", comment: "")
        case .ToDoList:
            return NSLocalizedString("agendaSection_checklist", comment: "")
        case .CostList:
            return NSLocalizedString("agendaSection_cost", comment: "")
        case .LinkList:
            return NSLocalizedString("agendaSection_link", comment: "")
        }
    }
}

class AddNewAgendaViewModel {
    
    var isUpdatingView = false
    var originalAgendaTable = TravelAgendaTable()
    
    var toDoList: Observable<[String]> = Observable([])
    var costList: Observable<[String]> = Observable([])
    var linkList: Observable<[String]> = Observable([])
    var memoText: Observable<String> = Observable("")
    
    var dateList: Observable<[Date]> = Observable([])
    
    var savedImages = [UIImage]()
    var newTravelAgendaTable = TravelAgendaTable()
    
    var placeName: String? = nil
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let result = dateFormatter.string(from: date)
        
        return result
    }
    
    func deleteFromToDoList(item: String) {
        let arr = toDoList.value
        for i in 0..<arr.count {
            if arr[i] == item {
                toDoList.value.remove(at: i)
            }
        }
    }
    
    func deleteFromCostList(item: String) {
        let arr = costList.value
        for i in 0..<arr.count {
            if arr[i] == item {
                costList.value.remove(at: i)
            }
        }
    }
    
    func deleteFromLinkList(item: String) {
        let arr = linkList.value
        for i in 0..<arr.count {
            if arr[i] == item {
                linkList.value.remove(at: i)
            }
        }
    }
}

//
//  AddNewAgendaViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import Foundation
import UIKit
import RealmSwift

enum Section: String, CaseIterable {
    case MemoText = "메모"
    case ToDoList = "체크리스트"
    case CostList = "예상 비용"
    case LinkList = "링크"
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

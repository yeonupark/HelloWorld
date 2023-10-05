//
//  AddNewAgendaViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import Foundation

enum Section: String, CaseIterable {
    case MemoText = "메모"
    case ToDoList = "체크리스트"
    case CostList = "예상 비용"
    case LinkList = "링크"
}

class AddNewAgendaViewModel {
    
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

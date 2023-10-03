//
//  AddNewAgendaViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/09/28.
//

import Foundation

enum Section: String, CaseIterable {
    case MemoText = "메모"
    case CheckList = "체크리스트"
    case CostList = "예상 비용"
    case LinkList = "링크"
}

class AddNewAgendaViewModel {
    
    //var checkList: Observable<[String]> = Observable([])
    var checkList = Observable(["잠자기", "밥먹기", "쇼핑하기"])
    //var costList: Observable<[String]> = Observable([])
    var costList = Observable(["10,000원", "45,600원"])
    //var linkList: Observable<[String]> = Observable([])
    var linkList = Observable(["www.naver.com"])
    var memoText: Observable<String> = Observable("")
    
    var dateList: Observable<[Date]> = Observable([])
    
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let result = dateFormatter.string(from: date)
        
        return result
    }

}

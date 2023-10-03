//
//  TravelAgendaTable.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/03.
//

import Foundation
import RealmSwift

class TravelAgendaTable: Object {
    
    //1. 제목 2. 날짜 3. 체크리스트 4. 메모 5. 예상 비용 6. 링크 7. 사진 (8. 지도)
    @Persisted(primaryKey: true) var _id: ObjectId
    
}

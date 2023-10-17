//
//  AddNewPhotoViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/02.
//

import Foundation
import UIKit

class AddNewPhotoViewModel {
    
    var isFromAddNewAgendaVC = false
    var tableID : String?
    var originalNumberOfPhotos : Int = 0
    
    var photoList: Observable<[UIImage]> = Observable([])
    var isEditable: Observable<Bool> = Observable(false)
    
    var pngValueList: [Int] = []
}

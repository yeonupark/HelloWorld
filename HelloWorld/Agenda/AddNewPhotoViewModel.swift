//
//  AddNewPhotoViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/02.
//

import Foundation
import UIKit

class AddNewPhotoViewModel {
    
    var photoList: Observable<[UIImage]> = Observable([])
    var isEditable: Observable<Bool> = Observable(false)
}

//
//  MyMapViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/10.
//

import Foundation
import MapKit

class MyMapViewModel {
    
    var searchedResults: Observable<[String]> = Observable([])
    
    var placeName: Observable<String> = Observable("")
    var latitude: Observable<CLLocationDegrees> = Observable(0)
    var longitude: Observable<CLLocationDegrees> = Observable(0)
}

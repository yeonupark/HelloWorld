//
//  WorldTimeAPIManager.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/12.
//

import Foundation
import Alamofire

struct WorldTime: Codable {
    
    let timezone: String
    let datetime: String
    let date: String
    let year: String
    let month: String
    let day: String
    let hour: String
    let minute: String
    let second: String
    let day_of_week: String
}

class WorldTimeAPIManager {
    
    static let shared = WorldTimeAPIManager()
    
    private init() { }
    
//    func callRequest(lat: Double, lon: Double, completionHandler: @escaping (WorldTime?) -> Void) {
//        
//        let url = "https://api.api-ninjas.com/v1/worldtime"
//        let header : HTTPHeaders = [
//            "X-Api-Key": APIKeys.ningaID
//        ]
//        let parameter : Parameters = ["lat" : lat, "lon" : lon]
//        
//        AF.request(url, method: .get, parameters: parameter, headers: header).validate().responseDecodable(of: WorldTime.self) { response in
//            guard let value = response.value else {
//                completionHandler(nil)
//                return
//            }
//            completionHandler(value)
//        }
//    }
}

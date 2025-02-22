//
//  ExchangeRateAPIManager.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import Foundation
import Alamofire

enum APIKeys {
    static let exchangeRateURL = "https://api.frankfurter.dev/v1/latest"
}

struct ExchangeRate: Codable {
    
    let base : String
    let date : String
    let rates: [String: Double]
}

class ExchangeRateAPIManager {
    
    static let shared = ExchangeRateAPIManager()
    
    private init() { }
    
    func callRequest(from: String, to: String, completionHandler: @escaping (ExchangeRate?) -> Void) {
        
        let url = APIKeys.exchangeRateURL
        let parameter : Parameters = ["base": from]
        
        AF.request(url, method: .get, parameters: parameter).validate().responseDecodable(of: ExchangeRate.self) { response in
            guard let value = response.value else {
                print("Exchange Rate API 호출 중 오류 발생")
                completionHandler(nil)
                return
            }
            completionHandler(value)
        }
    }
}

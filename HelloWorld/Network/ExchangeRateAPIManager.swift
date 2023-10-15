//
//  ExchangeRateAPIManager.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import Foundation
import Alamofire

struct ExchangeRate: Codable {
    
    let currency_pair : String
    let exchange_rate : Double
}

class ExchangeRateAPIManager {
    
    static let shared = ExchangeRateAPIManager()
    
    private init() { }
    
    func callRequest(from: String, to: String, completionHandler: @escaping (ExchangeRate?) -> Void) {
        
        let pair: String = "\(from)_\(to)"
        
        let url = "https://api.api-ninjas.com/v1/exchangerate"
        let header : HTTPHeaders = [
            "X-Api-Key": APIKeys.ningaID
        ]
        let parameter : Parameters = ["pair": pair]
        
        AF.request(url, method: .get, parameters: parameter, headers: header).validate().responseDecodable(of: ExchangeRate.self) { response in
            guard let value = response.value else {
                print("Exchange Rate API 호출 중 오류 발생")
                completionHandler(nil)
                return
            }
            completionHandler(value)
        }
    }
}

//
//  ExchangeRateViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import Foundation

class ExchangeRateViewModel {
    
    let currencyList: [String] = ["KRW 대한민국", "ZAR 남아프리카 공화국", "NPR 네팔", "NOK 노르웨이", "NZD 뉴질랜드", "TWD 대만", "DKK 덴마크", "RUB 러시아", "MOP 마카오", "MYR 말레이시아", "MXN 멕시코", "MNT 몽골", "USD 미국", "BHD 바레인", "BDT 방글라데시", "VND 베트남", "BRL 브라질", "BND 브루나이", "SAR 사우디아라비아", "SEK 스웨덴", "CHF 스위스", "SGD 싱가포르", "AED 아랍에미리트", "GBP 영국", "OMR 오만", "JOD 요르단", "EUR 유럽연합", "ILS 이스라엘", "EGP 이집트", "INR 인도", "IDP 인도네시아", "JPY 일본", "CNY 중국", "CZK 체코", "CLP 칠레", "KZT 카자흐스탄", "QAR 카타르", "CAD 캐나다", "KWD 쿠웨이트", "THB 태국", "TRY 튀르키예", "PKR 파키스탄", "PLN 폴란드", "PHP 필리핀", "HUF 헝가리", "AUD 호주", "HKD 홍콩"]
    
    var originalCurrency: Observable<String?> = Observable(nil)
    var convertedCurrency: Observable<String?> = Observable(nil)
    
    var originalMoney: Observable<Int?> = Observable(nil)
    var convertedMoney: Observable<Double?> = Observable(nil)
    
    var exchangeRate: Double = 1
}

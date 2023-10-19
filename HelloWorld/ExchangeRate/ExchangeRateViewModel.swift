//
//  ExchangeRateViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import Foundation

class ExchangeRateViewModel {
    
    let nationList: [Nation] = [Nation(nation: "대한민국", currency: "KRW", code: "kr", unit: "원"), Nation(nation: "남아프리카", currency: "ZAR", code: "za", unit: "랜드"), Nation(nation: "네팔", currency: "NPR", code: "np", unit: "루피"), Nation(nation: "노르웨이", currency: "NOK", code: "no", unit: "크로네"), Nation(nation: "뉴질랜드", currency: "NZD", code: "nz", unit: "달러"), Nation(nation: "대만", currency: "TWD", code: "tw", unit: "달러"), Nation(nation: "덴마크", currency: "DKK", code: "dk", unit: "크로네"), Nation(nation: "러시아", currency: "RUB", code: "ru", unit: "루블"), Nation(nation: "마카오", currency: "MOP", code: "mo", unit: "파타카"), Nation(nation: "말레이시아", currency: "MYR", code: "my", unit: "링깃"), Nation(nation: "멕시코", currency: "MXN", code: "mx", unit: "페소"), Nation(nation: "몽골", currency: "MNT", code: "mn", unit: "투그릭"), Nation(nation: "미국", currency: "USD", code: "us", unit: "달러"), Nation(nation: "바레인", currency: "BHD", code: "bh", unit: "디나르"), Nation(nation: "방글라데시", currency: "BDT", code: "bd", unit: "타카"), Nation(nation: "베트남", currency: "VND", code: "vn", unit: "동"), Nation(nation: "브라질", currency: "BRL", code: "br", unit: "헤알"), Nation(nation: "브루나이", currency: "BND", code: "bn", unit: "달러"), Nation(nation: "사우디아라비아", currency: "SAR", code: "sa", unit: "리얄"), Nation(nation: "스웨덴", currency: "SEK", code: "se", unit: "크로나"), Nation(nation: "스위스", currency: "CHF", code: "ch", unit: "프랑"), Nation(nation: "싱가포르", currency: "SGD", code: "sg", unit: "달러"), Nation(nation: "아랍에미리트", currency: "AED", code: "ae", unit: "디르함"), Nation(nation: "영국", currency: "GBP", code: "gb", unit: "파운드"), Nation(nation: "오만", currency: "OMR", code: "om", unit: "리알"), Nation(nation: "요르단", currency: "OD", code: "od", unit: "디나르"), Nation(nation: "유럽연합", currency: "EUR", code: "eu", unit: "유로"), Nation(nation: "이스라엘", currency: "ILS", code: "il", unit: "세켈"), Nation(nation: "이집트", currency: "EGP", code: "eg", unit: "파운드"), Nation(nation: "인도", currency: "INR", code: "in", unit: "루피"), Nation(nation: "인도네시아", currency: "IDP", code: "id", unit: "루피아"), Nation(nation: "일본", currency: "JPY", code: "jp", unit: "엔"), Nation(nation: "중국", currency: "CNY", code: "cn", unit: "위안"), Nation(nation: "체코", currency: "CZK", code: "cz", unit: "코루나"), Nation(nation: "칠레", currency: "CLP", code: "cl", unit: "페소"), Nation(nation: "카자흐스탄", currency: "KZT", code: "kz", unit: "텡게"), Nation(nation: "카타르", currency: "QAR", code: "qa", unit: "리얄"), Nation(nation: "캐나다", currency: "CAD", code: "ca", unit: "달러"), Nation(nation: "쿠웨이트", currency: "KWD", code: "kw", unit: "디나르"), Nation(nation: "태국", currency: "THB", code: "th", unit: "바트"), Nation(nation: "튀르키예", currency: "TRY", code: "tr", unit: "리라"), Nation(nation: "파키스탄", currency: "PKR", code: "pk", unit: "루피"), Nation(nation: "폴란드", currency: "PLN", code: "pl", unit: "즈워티"), Nation(nation: "필리핀", currency: "PHP", code: "ph", unit: "페소"), Nation(nation: "헝가리", currency: "HUF", code: "hu", unit: "포린트"), Nation(nation: "호주", currency: "AUD", code: "au", unit: "달러"), Nation(nation: "홍콩", currency: "HKD", code: "hk", unit: "달러")]
    
    var originalNation: Observable<Nation?> = Observable(nil)
    var convertedNation: Observable<Nation?> = Observable(nil)
    
    var originalMoney: Observable<Int?> = Observable(nil)
    var convertedMoney: Observable<Double?> = Observable(nil)
    
    var exchangeRate: Double = 1
    
    func exchange(originalMoney: Double) -> Double {
        let convertedMoney = originalMoney * exchangeRate
        
        return convertedMoney
    }
    
    func format(for number: Double) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
}

struct Nation {
    var nation: String
    var currency: String
    var code: String
    var unit: String
}

//
//  ExchangeRateViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/15.
//

import Foundation

class ExchangeRateViewModel {
    
    let nationList: [Nation] = [Nation(nation: NSLocalizedString("kr", comment: ""), currency: "KRW", code: "kr", unit: NSLocalizedString("kr_cur", comment: "")), Nation(nation: NSLocalizedString("nz", comment: ""), currency: "NZD", code: "nz", unit: NSLocalizedString("nz_cur", comment: "")), Nation(nation: NSLocalizedString("dk", comment: ""), currency: "DKK", code: "dk", unit: NSLocalizedString("dk_cur", comment: "")), Nation(nation: NSLocalizedString("us", comment: ""), currency: "USD", code: "us", unit: NSLocalizedString("us_cur", comment: "")), Nation(nation: NSLocalizedString("ch", comment: ""), currency: "CHF", code: "ch", unit: NSLocalizedString("ch_cur", comment: "")), Nation(nation: NSLocalizedString("gb", comment: ""), currency: "GBP", code: "gb", unit: NSLocalizedString("gb_cur", comment: "")), Nation(nation: NSLocalizedString("eu", comment: ""), currency: "EUR", code: "eu", unit: NSLocalizedString("eu_cur", comment: "")), Nation(nation: NSLocalizedString("jp", comment: ""), currency: "JPY", code: "jp", unit: NSLocalizedString("jp_cur", comment: "")), Nation(nation: NSLocalizedString("cn", comment: ""), currency: "CNY", code: "cn", unit: NSLocalizedString("cn_cur", comment: "")), Nation(nation: NSLocalizedString("ca", comment: ""), currency: "CAD", code: "ca", unit: NSLocalizedString("ca_cur", comment: "")), Nation(nation: NSLocalizedString("tr", comment: ""), currency: "TRY", code: "tr", unit: NSLocalizedString("tr_cur", comment: "")), Nation(nation: NSLocalizedString("pl", comment: ""), currency: "PLN", code: "pl", unit: NSLocalizedString("pl_cur", comment: "")), Nation(nation: NSLocalizedString("au", comment: ""), currency: "AUD", code: "au", unit: NSLocalizedString("au_cur", comment: "")), Nation(nation: NSLocalizedString("hk", comment: ""), currency: "HKD", code: "hk", unit: NSLocalizedString("hk_cur", comment: ""))]
    
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

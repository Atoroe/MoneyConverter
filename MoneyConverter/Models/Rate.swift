//
//  Exchange.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

struct Rate: Codable {
    let conversionRates: [String : Double]?

    enum CodingKeys: String, CodingKey {
        case conversionRates = "conversion_rates"
    }
}



/*
struct ConversionRates : Codable {
    let rub : Double?
    let aud : Double?
    let brl : Double?
    let byn : Double?
    let cad : Double?
    let chf : Double?
    let cny : Double?
    let eur : Double?
    let gbp : Double?
    let tRY : Double?
    let usd : Double?
    let zar : Double?
    let jpy : Double?
    let sek : Double?
    let mxn : Double?
    let nzd : Double?
    let sgd : Double?
    let hkd : Double?
    let nok : Double?
    let krw : Double?
    let inr : Double?
    
    


    enum CodingKeys: String, CodingKey {
        case rub = "RUB"
        case aud = "AUD"
        case brl = "BRL"
        case byn = "BYN"
        case cad = "CAD"
        case chf = "CHF"
        case cny = "CNY"
        case eur = "EUR"
        case gbp = "GBP"
        case tRY = "TRY"
        case usd = "USD"
        case zar = "ZAR"
        case jpy = "JPY"
        case sek = "SEK"
        case mxn = "MXM"
        case nzd = "NZD"
        case sgd = "SGD"
        case hkd = "HKD
        case nok = "NOK"
        let krw : Double?
        let inr : Double?
    }
}
*/




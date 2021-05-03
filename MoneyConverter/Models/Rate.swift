//
//  Exchange.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

struct Rate: Codable {
    let baseCode: String?
    let conversionRates: ConversionRates?

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
    
    struct ConversionRates: Codable{
        let rus: Double?
        let eur: Double?
        let usd: Double?
        
        enum CodingKeys: String, CodingKey {
            case rus = "RUS"
            case eur = "EUR"
            case usd = "USD"
        }
    }

}




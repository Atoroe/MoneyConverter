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

//
//  Exchange.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

struct Rate: Codable {
    let baseCode: String?
    let conversionRates: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}



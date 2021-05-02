//
//  Exchange.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

struct Exchange: Codable {
    let result: String?
    let timeLastUpdateUTC: String?
    let timeNextUpdateUTC, baseCode: String?
    let conversionRates: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case result
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}

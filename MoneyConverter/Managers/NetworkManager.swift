//
//  NetworkManager.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

import Foundation

enum Code: String {
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
}

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    let key = "667fa215140eb6a05a16c31a"
    
    func getConvertionRates(code: Code, complition: @escaping ((Exchange?) -> ())) {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(key)/latest/\(code.rawValue)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            var decoderExchange : Exchange?
            do {
                decoderExchange = try JSONDecoder().decode(Exchange.self, from: data)
                DispatchQueue.main.async {
                    complition(decoderExchange)
                }
            } catch let error{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
}


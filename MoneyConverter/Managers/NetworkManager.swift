//
//  NetworkManager.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

import Foundation

enum Code: String, CaseIterable{
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
}

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    let key = "667fa215140eb6a05a16c31a"
    
    func getRate(code: Code, complition: @escaping ((Rate?) -> ())) {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(key)/latest/\(code.rawValue)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            var decoderRate : Rate?
            do {
                decoderRate = try JSONDecoder().decode(Rate.self, from: data)
                DispatchQueue.main.async {
                    complition(decoderRate)
                }
            } catch let error{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
}


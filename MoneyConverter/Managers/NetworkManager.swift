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
    let code = Code.rub
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "v6.exchangerate-api.com"
        components.path = "/v6/" + key + "/latest/" + code.rawValue
        guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)") }
        return url
    }
    
    func fetchData(with complition: @escaping (Rate?) -> Void) {
        URLSession.shared.dataTask(with: self.url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let rate = try JSONDecoder().decode(Rate.self, from: data)
                DispatchQueue.main.async {
                    complition(rate)
                }
            } catch let error{
                print(error)
            }
        }.resume()
        
    }
    
}


//
//  NetworkManager.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

import Alamofire

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    let key = "667fa215140eb6a05a16c31a"
    let code = "RUB"
    
    let url = "https://v6.exchangerate-api.com/v6/667fa215140eb6a05a16c31a/latest/USD"
    
    func fetchData(with complition: @escaping (Rate?) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: Rate.self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        complition(value)
                    }
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
}

//
//  ViewController.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

import UIKit

class ViewController: UIViewController {
    
    var exchange: Exchange? {
        didSet {
            print(exchange!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getConvertionRates(code: Code.rub) { (exchange) in
            self.exchange = exchange
        }
    }


}


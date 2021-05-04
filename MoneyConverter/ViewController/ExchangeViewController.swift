//
//  ViewController.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

import UIKit
import Alamofire

class ExchangeViewController: UIViewController {
    
    @IBOutlet var currencyTextFields: [UITextField]!
    
    let url = "https://v6.exchangerate-api.com/v6/667fa215140eb6a05a16c31a/latest/RUB"
    
    var rates: Rate? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget(to: currencyTextFields)
        addIconsToTextFields()
        
        alamofireFetchData()
    }
    
    func alamofireFetchData() {
        AF.request(url)
            .validate()
            .responseDecodable(of: Rate.self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    self.rates = value
                    DispatchQueue.main.async {
                        print(self.rates as Any)
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
}

//MARK: - Private Methods
//extension ExchangeViewController {
//    private func fetchExchangeRates() {
//        let codes = Code.allCases
//        print(codes)
//        for code in codes {
//            NetworkManager.shared.fetchData(from: url) { (rate) in
//                guard let rate = rate else { return }
//                self.rates?.append(rate)
//            }
//                 }
//    }
//}

//MARK: - Text Fields
extension ExchangeViewController: UITextFieldDelegate {
    private func addTarget(to textFieldes: [UITextField]) {
        for textField in textFieldes {
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.isEmpty {
            currencyTextFields.forEach { (currencyTF) in
                if currencyTF.tag != textField.tag {
                    currencyTF.text = "0"
                }
            }
        } else {
        }
    }
    
    
    private func addIconsToTextFields() {
        currencyTextFields.forEach { (textField) in
            switch textField.tag {
            case 0:
                let userIcon = UIImage(named: "rus")
                setPaddingWithImage(image: userIcon!, textField: textField)
            case 1:
                let userIcon = UIImage(named: "usa")
                setPaddingWithImage(image: userIcon!, textField: textField)
            default:
                let userIcon = UIImage(named: "eur")
                setPaddingWithImage(image: userIcon!, textField: textField)
            }
        }
    }
    
    
    
    func setPaddingWithImage(image: UIImage, textField: UITextField){
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        textField.rightViewMode = .always
        view.addSubview(imageView)
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = view
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


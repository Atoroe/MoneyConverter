//
//  ViewController.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currencyTextFields: [UITextField]!
    
    var rates: [Rate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getExchangeRates()
        addTarget(to: currencyTextFields)
        addIconsToTextFields()
    }
    
}

//MARK: - Private Methods
extension ViewController {
    private func getExchangeRates() {
        for code in Code.allCases {
            NetworkManager.shared.getRate(code: code) { (rate) in
                guard let rate = rate else { return }
                self.rates.append(rate)
            }
        }
    }
}

//MARK: - Text Fields
extension ViewController: UITextFieldDelegate {
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
            guard let ammount = Double(textField.text!) else { return }
            
            switch textField.tag {
            case 0:
                currencyTextFields[1].text = String(ammount * rates[1].conversionRates!["USD"]!)
                currencyTextFields[2].text = String(ammount * rates[2].conversionRates!["EUR"]!)
            case 1:
                currencyTextFields[0].text = String(ammount * rates[0].conversionRates!["RUB"]!)
                currencyTextFields[2].text = String(ammount * rates[2].conversionRates!["EUR"]!)
            default:
                currencyTextFields[0].text = String(ammount * rates[0].conversionRates!["RUB"]!)
                currencyTextFields[1].text = String(ammount * rates[1].conversionRates!["USD"]!)
            }
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


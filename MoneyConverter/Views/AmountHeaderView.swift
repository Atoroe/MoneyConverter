//
//  AmountCell.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 6.05.21.
//

import UIKit

class AmountHeaderView: UITableViewCell {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var flagImageView: UIImageView!
    
    var amount: Double = 0
    var delegate: AmountCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTargetToTextFied()
    }
    
    func setHeader(with code: String) {
        codeLabel.text = code
    }
    
}

//MARK: - Text Field
extension AmountHeaderView {
    private func addTargetToTextFied() {
        amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if amountTextField.text!.isEmpty {
            amountTextField.text = "0"
        } else {
            guard let amount = Double(amountTextField.text ?? "0") else { return }
            self.amount = amount
        }
        delegate.setNewValue(for: amount)
    }
}


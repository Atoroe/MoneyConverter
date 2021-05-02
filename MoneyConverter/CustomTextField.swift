//
//  CustomTextField.swift
//  MoneyConverter
//
//  Created by Artiom Poluyanovich on 2.05.21.
//

import  UIKit

class CustomTextField: UITextField {
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        
        return originalRect.offsetBy(dx: -40, dy: 0)
    }
}



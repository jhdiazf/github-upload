//
//  StackNumber.swift
//  CoolCalc
//
//  Created by Hector Diaz on 3/20/22.
//

import Foundation

class StackNumber: StackElement {
    
    func getNumber() -> Double {
        if let number = Double(self.element) {
            return number
        } else {
            return 0
        }
    }
    
    override func getText() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 15
        
        guard let number = formatter.number(from: self.element) else {return ""}
        
        if let numberString = formatter.string(from: number) {
            return numberString
        } else {
            return ""
        }
    }
}

//
//  StackOperation.swift
//  CoolCalc
//
//  Created by Hector Diaz on 3/21/22.
//

import Foundation

enum Operation: String {
    case sum = "+"
    case rest = "-"
    case multiplication = "*"
    case division = "/"
}

class StackOperation: StackElement {
    
    init (operation: Operation) {
        super.init(element: operation.rawValue)
    }
    
    func getOperation() -> Operation {
        return Operation(rawValue: self.element)!
    }
    
}

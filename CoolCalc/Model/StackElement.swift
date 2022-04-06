//
//  StackElement.swift
//  CoolCalc
//
//  Created by Hector Diaz on 3/20/22.
//

import Foundation

class StackElement {
    var element: String = ""
    
    init(element: String) {
        self.element = element
    }
    
    func getText() -> String {
        return element
    }
}

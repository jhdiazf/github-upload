//
//  Calculator.swift
//  CoolCalc
//
//  Created by Hector Diaz on 3/20/22.
//

import Foundation

struct Calculator {
    var operationStack: [StackElement] = [StackNumber(element: "0")]
    
    func getStackString() -> String {
        var operation = ""
        for stackElement in operationStack {
            operation += stackElement.getText()
        }
        return operation
    }
    
    mutating func addCharToLastStackElement(_ charToAdd: String) {
        var lastIndex = operationStack.count - 1
        if !(operationStack[lastIndex] is StackNumber) {
            operationStack.append(StackNumber(element: "0"))
            lastIndex += 1
        }
        
        if operationStack[lastIndex].element == "0" {
            operationStack[lastIndex].element = "\(charToAdd)"
        } else {
            operationStack[lastIndex].element += "\(charToAdd)"
        }
    }
    
    mutating func addPointToLastStackElement() {
        let lastIndex = operationStack.count - 1
        guard let stackNumber = operationStack[lastIndex] as? StackNumber else {
            return
        }
        
        if stackNumber.element.contains(".") {
            return
        } else {
            operationStack[lastIndex].element += "."
        }
    }
    
    mutating func changeSign() {
        //let lastIndex = operationStack.count - 1
        guard let stackNumber = operationStack.last as? StackNumber else { return }
        
        if stackNumber.element.contains("-") {
            operationStack.last?.element.removeFirst()
        } else {
            operationStack.last?.element = "-" + operationStack.last!.element
        }
    }
    
    mutating func applyPercentage() {
        guard let stackNumber = operationStack.last as? StackNumber else { return }
        let lastIndex = operationStack.count - 1
        operationStack[lastIndex] = StackNumber(element: "\(stackNumber.getNumber() / 100)")
    }
    
    mutating func addToStack(operation: Operation) {
        let lastIndex = operationStack.count - 1
        
        if operationStack[lastIndex] is StackNumber && operationStack[lastIndex].element != "" {
            operationStack.append(StackOperation(operation: operation))
            operationStack.append(StackNumber(element: ""))
        } else if operationStack[lastIndex] is StackOperation {
            operationStack[lastIndex] = StackOperation(operation: operation)
            operationStack.append(StackNumber(element: ""))
        } else {
            operationStack[lastIndex-1] = StackOperation(operation: operation)
        }
    }
    
    mutating func solveOperationStack() -> Double {
        var stackElements = operationStack.count
        var result: Double = 0
        
        if operationStack[stackElements-1].element == "" {
            operationStack.removeLast()
            stackElements -= 1
        }
        
        while stackElements > 1 {
            let lastIndex = operationStack.count - 1
            if operationStack[lastIndex] is StackNumber && stackElements >= 3 {
                guard let secondOperand = operationStack[lastIndex] as? StackNumber else {return 0}
                guard let firstOperand = operationStack[lastIndex - 2] as? StackNumber else {return 0}
                guard let operation = operationStack[lastIndex - 1] as? StackOperation else {return 0}
                operationStack.removeLast(3)
                
                result = doOperation(operation.getOperation(), toNumOne: firstOperand.getNumber(), andNumTwo: secondOperand.getNumber())
                
                operationStack.append(StackNumber(element: "\(result)"))
                stackElements -= 2
            } else if operationStack[lastIndex] is StackOperation {
                guard let firstOperand = operationStack[lastIndex - 1] as? StackNumber else {return 0}
                guard let operation = operationStack[lastIndex] as? StackOperation else {return 0}
                operationStack.removeLast(2)
                
                result = doOperation(operation.getOperation(), toNumOne: firstOperand.getNumber(), andNumTwo: firstOperand.getNumber())
                
                operationStack.append(StackNumber(element: "\(result)"))
                stackElements -= 1
            }
            
        }
        
        guard let operandNumber = operationStack[0] as? StackNumber else {return 0}
        return operandNumber.getNumber()
        
    }
    
    func doOperation(_ operation: Operation, toNumOne firstOperand: Double, andNumTwo secondOperand: Double) -> Double {
        switch operation {
        case .sum:
            return firstOperand + secondOperand
        case .rest:
            return firstOperand - secondOperand
        case .multiplication:
            return firstOperand * secondOperand
        case .division:
            return firstOperand / secondOperand
        }
    }
    
}







//
//  ViewController.swift
//  CoolCalc
//
//  Created by Hector Diaz on 3/20/22.
// Just a change for Git again

import UIKit

class ViewController: UIViewController {
    
    var calculator: Calculator = Calculator()
    
    @IBOutlet weak var operationLbl: UILabel!
    @IBOutlet weak var resutLbl: UILabel!
    @IBOutlet weak var clearBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clearCalculator()
        presentStackElements()
    }
    
    func clearCalculator() {
        calculator.operationStack = [StackNumber(element: "0")]
        clearBtn.setTitle("AC", for: .normal)
        resutLbl.text = ""
    }
    
    func presentStackElements() {
        operationLbl.text = calculator.getStackString()
    }
    
    @IBAction func ClearBtnPressed(_ sender: Any) {
        if let btnTitle = clearBtn.title(for: .normal) {
            if btnTitle == "AC" {
                clearCalculator()
            } else {
                clearBtn.setTitle("AC", for: .normal)
                if calculator.operationStack.count > 1 {
                    calculator.operationStack.removeLast()
                } else {
                    clearCalculator()
                }
            }
        }
        presentStackElements()
    }
    
    @IBAction func SignBtnPressed(_ sender: Any) {
        calculator.changeSign()
        refreshView()
    }
    
    @IBAction func PercentageBtnPressed(_ sender: Any) {
        calculator.applyPercentage()
        refreshView()
    }
    
    
    
    @IBAction func EqualBtnPressed(_ sender: Any) {
        presentResultLbl(result: calculator.solveOperationStack())
    }
    
    @IBAction func operationBtnPressed(_ sender: UIButton) {
        if let element = sender.titleLabel?.text, let operation = Operation(rawValue: element) {
            calculator.addToStack(operation: operation)
            refreshView()
        }
    }
    
    //
    
    @IBAction func digitBtnPressed(_ sender: UIButton) {
        if let element = sender.titleLabel?.text {
            calculator.addCharToLastStackElement(element)
            refreshView()
        }
    }
    
    @IBAction func PointBtnPressed(_ sender: Any) {
        calculator.addPointToLastStackElement()
        refreshView()
    }
    
    func presentResultLbl(result: Double) {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 15
        
        guard let resultNSNumber = formatter.number(from: "\(result)") else { return }
        
        resutLbl.text = formatter.string(from: resultNSNumber)
    }
    
    func refreshView() {
        clearBtn.setTitle("C", for: .normal)
        presentStackElements()
    }
    
}



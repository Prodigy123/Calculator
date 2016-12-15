//
//  ViewController.swift
//  NewCalculator
//
//  Created by 吉安 on 25/11/2016.
//  Copyright © 2016 An Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var displayNum: UILabel!
    private var userIsInTheMiddleOfTyping=false
    @IBAction private func clickTheNum(_ sender: UIButton)
    {
        if let clickNum = sender.currentTitle{
            if userIsInTheMiddleOfTyping{
                displayNum.text = displayNum.text!+clickNum}
            else{
                displayNum.text = clickNum
                userIsInTheMiddleOfTyping = true
            }
        }
    }
    private var displayValue: Double{
        set{
            displayNum.text = String(newValue)
        }
        get{
            return Double(displayNum.text!)!
        }
    }
    private var brain = CalculatorBrain()
    @IBAction private func operatorButton(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{
            brain.setOprand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let operation = sender.currentTitle{
            brain.performeOperation(symbol: operation)
        }
        displayValue = brain.result
    }
}

//
//  NewCalcularBrain.swift
//  NewCalculator
//
//  Created by 吉安 on 25/11/2016.
//  Copyright © 2016 An Ji. All rights reserved.
//

import Foundation
class CalculatorBrain{
    private var accumulator = 0.0
    func setOprand(operand: Double)  {
        accumulator = operand
    }
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    private let relationship: Dictionary<String,Operation>=[
        "π":Operation.Constant(M_PI),
        "e":Operation.Constant(M_E),
        "±":Operation.UnaryOperation{-$0},
        "√":Operation.UnaryOperation(sqrt),
        "cos":Operation.UnaryOperation(cos),
        "+":Operation.BinaryOperation{$0+$1},
        "-":Operation.BinaryOperation{$0-$1},
        "x":Operation.BinaryOperation{$0*$1},
        "%":Operation.BinaryOperation{$0/$1},
        "=":Operation.Equals,
        "AC":Operation.Constant(0.0)
        
    ]
    private var pending: saveTheFirstOneAndFunction?
    private struct saveTheFirstOneAndFunction{
        var pendFunc: (Double,Double)->Double
        var firstNum: Double
    }
    func performeOperation(symbol: String){
        if let content = relationship[symbol]{
            switch content
            {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                multipleHelp()
                pending = saveTheFirstOneAndFunction(pendFunc: function, firstNum: accumulator)
            case .Equals:
                multipleHelp()
            }
        }
    }
    private func multipleHelp(){
        if pending != nil{
            accumulator = pending!.pendFunc(pending!.firstNum,accumulator)
            pending = nil
        }
    }
    var result:Double{
        return accumulator
    }
}

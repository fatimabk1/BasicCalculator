//
//  StringExtensions.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/31/24.
//

import Foundation


// TODO: throw errors on failure
extension String {
    func isOperator() -> Bool {
        ["+", "-", "x", "/", "sin", "cos", "tan"].contains(where: {$0 == self})
    }
    
    func isUnaryOperator() -> Bool {
        ["sin", "cos", "tan"].contains(where: {$0 == self})
    }
    
    func isBinaryOperator() -> Bool {
        ["+", "-", "x", "/"].contains(where: {$0 == self})
    }
    
    func isOperand() -> Bool {
        let digits = CharacterSet.decimalDigits
        let stringCharacters = CharacterSet(charactersIn: self)
        return digits.isSuperset(of: stringCharacters)
    }
    
    func toOperand() -> Double {
        return Double(self) ?? 0.0
    }
    
    func toOperator() -> OperatorAction {
        switch(self) {
        case "+":
                .add
        case "-":
                .subtract
        case "x":
                .multiply
        case "/":
                .divide
        case "sin":
                .sin
        case "cos":
                .cos
        case "tan":
                .tan
        case "_":
                .none
        default:
                .none
        }
    }
    
    func isEquals() -> Bool {
        return self == "="
    }
}

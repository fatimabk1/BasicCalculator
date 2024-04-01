//
//  StringExtensions.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/31/24.
//

import Foundation


extension String {
    func isOperator() -> Bool {
        ["+", "-", "x", "/", "Sin", "Cos", "Tan"].contains(where: {$0 == self})
    }
    
    func isUnaryOperator() -> Bool {
        ["Sin", "Cos", "Tan"].contains(where: {$0 == self})
    }
    
    func isBinaryOperator() -> Bool {
        ["+", "-", "x", "/"].contains(where: {$0 == self})
    }
        
    func isOperand() -> Bool {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from:self) != nil || self == "."
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
        case "Sin":
                .sin
        case "Cos":
                .cos
        case "Tan":
                .tan
        case "_":
                .none
        default:
                .none
        }
    }
}

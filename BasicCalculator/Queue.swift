//
//  Queue.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/31/24.
//

import Foundation

 enum OperatorAction {
    case add, subtract, multiply, divide, sin, cos, tan, none, equals

    func toString() -> String{
        switch(self) {
        case .add:
            "+"
        case .subtract:
            "-"
        case .multiply:
            "x"
        case .divide:
            "/"
        case .sin:
            "sin"
        case .cos:
            "cos"
        case .tan:
            "tan"
        case .none:
            "_"
        case .equals:
            "-"
        }
    }
}

struct OperationQueue {
    private var items = ["0"]
    var count: Int { items.count }
    var lastInputValue: String {
        let index = items.lastIndex(where: {$0.isOperand()}) ?? 0
        return items[index]
    }
        
    var hasComputableUnaryOperator: Bool {
        return (items.count == 2 && items[1].isUnaryOperator() && items[0].isOperand())
    }
    var hasComputableBinaryOperator: Bool {
        return (items.count == 3 && items[2].isOperand() &&
                items[1].isBinaryOperator() && items[0].isOperand())
    }
    
    func toString() -> String {
        var str = "["
        for item in items {
            if item == "ERR" {
                str.append(contentsOf: item)
            } else {
                str.append(item)
            }
            str.append(", ")
        }
        str.append("]")
        return str
    }
    
    mutating func push(_ item: String) {
        items.append(item)
    }
    
    mutating func pop() -> String {
        return items.popLast() ?? "0"
    }
    
    mutating func replace(_ input: String) {
        _ = self.pop()
        self.push(input)
    }
    
    mutating func appendToLast(_ item: String) {
        guard !self.isEmpty() else { return }
        items[items.count - 1].append(contentsOf: item)
    }
    
    func peek() -> String {
        return items.last ?? "0"
    }
    
    func isEmpty() -> Bool {
        return items.count == 0
    }
        
    mutating func clear() {
        items = []
    }
    
    mutating func resetCalculation() {
        items = ["0"]
    }
    
    func canCompute() -> Bool {
        return hasComputableUnaryOperator || hasComputableBinaryOperator
    }

    func compute(onError: () -> Void) -> String {
        assert(hasComputableUnaryOperator || hasComputableBinaryOperator)
        
        var result = ""
        if hasComputableUnaryOperator {
            result = doMath(action: items[1].toOperator(), operandA: items[0].toOperand())
        } else { // hasComputableBinaryOperator
            result = doMath(action: items[1].toOperator(), operandA: items[0].toOperand(), operandB: items[2].toOperand())
        }
        
        if result == "ERR" {
            onError()
        }
        
        return result
    }

    func computeEquals(onError: () -> Void) -> String { // pressed Equal --> must calculate with whatever we have
        if items.count == 1 { // only can be number - default starts with 0, so can't start with operator
            assert(items[0].isOperand())
            
            let result = doMath(action: .equals, operandA: items[0].toOperand())
            if result == "ERR" {
                onError()
            }
            return result
        } else if items.count == 2 { // [operand, operator] -- queue initialized with "0", so [operator, operand] will never happen
            let secondItem = items[1]
            let firstItem = items[0]
            assert(secondItem.isOperator())
            assert(firstItem.isOperand())
            
            var result = ""
            if secondItem.isUnaryOperator() {
                result = doMath(action: secondItem.toOperator(), operandA: firstItem.toOperand())
            } else {
                result = doMath(action: .equals, operandA: firstItem.toOperand())
            }
            
            if result == "ERR" {
                onError()
            }
            return result
        } else if items.count == 3 {
            let thirdItem = items[2]
            let secondItem = items[1]
            let firstItem = items[0]
            
            assert(thirdItem.isOperand())
            assert(secondItem.isOperator())
            assert(secondItem.isBinaryOperator())
            assert(firstItem.isOperand())

            let result = doMath(action: secondItem.toOperator(), operandA: firstItem.toOperand(), operandB: thirdItem.toOperand())
            if result == "ERR" {
                onError()
            }
            return result
        } else {
            // shouldn't get here, so fail
            assert(items.count <= 3)
            return "0"
        }
    }
                        
    func doMath(action: OperatorAction, operandA: Double, operandB: Double=0) -> String {
        switch(action){
        case .add:
            return String(format: "%g", operandA + operandB)
        case .subtract:
            return String(format: "%g", operandA - operandB)
        case .multiply:
            return String(format: "%g", operandA * operandB)
        case .divide:
            if operandB == 0 {
                return "ERR"
            }
            return String(format: "%g", operandA / operandB)
        case .sin:
            return String(format: "%g", sin(operandA))
        case .cos:
            return String(format: "%g", cos(operandA))
        case .tan:
            return String(format: "%g", tan(operandA))
        case .none:
            return "0"
        case .equals:
            return String(format: "%g", operandA)
        }
    }
}

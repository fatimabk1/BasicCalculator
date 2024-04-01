//
//  OperationQueue.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/31/24.
//

import Foundation

 enum OperatorAction {
    case add, subtract, multiply, divide, sin, cos, tan, none, equals
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
            let operation = items[1]
            let operand = items[0]
            assert(operation.isOperator())
            assert(operand.isOperand())
            
            var result = ""
            if operation.isUnaryOperator() {
                result = doMath(action: operation.toOperator(), operandA: operand.toOperand())
            } else {
                result = doMath(action: .equals, operandA: operand.toOperand())
            }
            
            if result == "ERR" {
                onError()
            }
            return result
        } else if items.count == 3 {
            let operandB = items[2]
            let operation = items[1]
            let operandA = items[0]
            
            assert(operandB.isOperand())
            assert(operation.isOperator())
            assert(operation.isBinaryOperator())
            assert(operandA.isOperand())

            let result = doMath(action: operation.toOperator(), operandA: operandA.toOperand(), operandB: operandB.toOperand())
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

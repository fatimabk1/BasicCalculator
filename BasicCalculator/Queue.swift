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

// TODO: throw errors on failure
struct Queue {
    private var items = ["0"]
    var count: Int { items.count }
    
    var hasComputableUnaryOperator: Bool {
        return (items.count == 2 && items[1].isUnaryOperator() && items[0].isOperand())
    }
    var hasComputableBinaryOperator: Bool {
        return (items.count == 3 && items[2].isOperand() &&
                items[1].isBinaryOperator() && items[0].isOperator())
    }
    
    mutating func push(_ item: String) {
        items.append(item)
    }
    
    mutating func pop() -> String {
        return items.popLast() ?? "0"
    }
    
    mutating func appendToLast(_ item: String) {
        guard !self.isEmpty() else { return }
        items[items.count - 1].append(item)
    }
    
    func peek() -> String {
        return items.last ?? "0"
    }
    
    func isEmpty() -> Bool {
        return items.count > 0
    }
        
    mutating func clear() {
        items = []
    }
    
    mutating func resetCalculation() {
        items = ["0"]
    }
    
    func canCompute() -> Bool {
        let hasComputableUnaryOperator = (items.count == 2 && items[1].isUnaryOperator() && items[0].isOperand())
        let hasComputableBinaryOperator = (items.count == 3 && 
                                           items[2].isOperand() &&
                                           items[1].isBinaryOperator() &&
                                           items[0].isOperator())
        
        return hasComputableUnaryOperator || hasComputableBinaryOperator
    }

    mutating func compute() -> Double {
        if hasComputableUnaryOperator {
           return doMath(action: items[1].toOperator(), operandA: items[0])
        } else { // hasComputableBinaryOperator
            return doMath(action: items[1].toOperator, operandA: items[0], operandB: items[2])
        }
    }

    mutating func computeEquals() -> Double { // pressed Equal --> must calculate with whatever we have
        if items.count == 1 { // only can be number - default starts with 0, so can't start with operator
            let item = self.pop()
            assert(item.isOperand())
            return Double(item) ?? 0.0
            
        } else if items.count == 2 { // [operator, operand] || [operand, operator]
            let secondItem = self.pop()
            let firstItem = self.pop()
            
            // MARK: case - [operator, operand]
            if lastItem.isOperand() {
                let operandB = lastItem.toOperand()
                let action = self.pop()
//                    action.isOperator()
//                guard action.isBin
                
                if lastItem.isUnaryOperator() {
                    return doMath(action: lastItem.toOperator(), operandA: self.pop().toOperand())
                } else { // binary operator
                    let operandA = self.pop().toOperand()
                    return doMath(action: lastItem.toOperator(), operandA: operandA, operandB: operandA)
                }
                
            } else { // MARK: case - [operand, operator]
                let lastItem = self.pop()
                if lastItem.isOperator() {
                    if lastItem.isUnaryOperator() {
                        return doMath(action: lastItem.toOperator(), operandA: self.pop().toOperand())
                    } else { // binary operator
                        let operandA = self.pop().toOperand()
                        return doMath(action: lastItem.toOperator(), operandA: operandA, operandB: operandA)
                    }
                }
            }
        } else { // items.count = 3
            guard let operandB = self.pop(), operandB.isOperand(),
                  let action = self.pop(), action.isOperator(),
                  let operandA = self.pop(), operandA.isOperand()
            else { return 0.0 }
        }
        
    }
                        
    func doMath(action: OperatorAction, operandA: Double, operandB: Double=0) -> Double {
        switch(action){
        case .add:
            return operandA + operandB
        case .subtract:
            return operandA - operandB
        case .multiply:
            return operandA * operandB
        case .divide:
            return operandA / operandB
        case .sin:
            return sin(operandA)
        case .cos:
            return cos(operandA)
        case .tan:
            return tan(operandA)
        case .none:
            return 0
        case .equals:
            return operandA
        }
    }

  
}

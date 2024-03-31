//
//  CalculatorViewModel.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/29/24.
//

import Foundation
import SwiftUI


final class CalculatorViewModel: ObservableObject {
    @Published var currentInput = "0"
    var operationQueue = Queue()
    var newCalculation = true
    
    func gotInput(_ input: String) {
        if input.isOperand() {
            if newCalculation {
                if operationQueue.peek().isOperand() {
                    _ = operationQueue.pop()
                    operationQueue.push(input)
                } else {
                    operationQueue.push(input)
                }
                newCalculation = false
            } else {
                if operationQueue.peek().isOperand(){
                    operationQueue.appendToLast(input)
                } else {
                    operationQueue.push(input)
                }
            }
        } else if input.isOperator() {
            // replace if we selected a different operator
            if operationQueue.peek().isOperator() {
                _ = operationQueue.pop()
                operationQueue.push(input)
            }
            
            // check if operationQueue can be evaluated and reduced before proceeding
            if operationQueue.canCompute() {
                let result = operationQueue.compute()
                operationQueue.clear()
                operationQueue.push(String(result))
            }
            
            // if unary operator, immediately push and reduce
            if input.isUnaryOperator() {
                operationQueue.push(input)
                let result = operationQueue.compute()
                operationQueue.clear()
                operationQueue.push(String(result))
            } else {
                operationQueue.push(input)
            }
        } else { // input.isEquals() == true
            let result = operationQueue.computeEquals()
            operationQueue.clear()
            operationQueue.push(String(result))
        }
    }
}











//    var hasOperand = false
//    var cumulativeResult = ""
//    var input = ""
//    var action: OperatorAction = .none

//    let numbers = ["1", "2","3", "4", "5", "6", "7", "8", "9", "0"]
//    let operatorList = ["+", "-", "x", "/", "=", "sin", "cos", "tan"]


      
//    func algorithm {
//        flag newCalculation = true // true default
//        [5 + 50 ] // queue starts with zero default -> queue w/push, pop, clear,count, peek (view first value)
//        5 + 5 * -
//        
//        got #
//            if !newCalculation
//                if prev is a number append
//                else push
//                
//            else
//                if prev is a number - replace
//                else push
//                newCalculation = false
//        got op
//            if prev is an op,
//                replace
//                continue
//            
//            if queue contains binary & have args
//                compute,
//                clear queue,
//                push result to queue,
//                newCalculation = true
//                push op
//            else if newOp is unary w/arg
//                push to queue,
//                compute,
//                clear queue,
//                push result to queue,
//                newCalculation = true
//            else push op
//
//        got =
//            if one item
//                return value
//            if two items w/binary function
//                push first value
//                compute sequence [111]
//            if three items
//                compute sequence [111]
//    }

//    var display: String {
//        if currentInput == "0" {
//            return "0"
//        } else {
//            guard let firstNonZeroValue = currentInput.firstIndex(where: {$0 != "0"}) else {
//                return "0"
//            }
//            return String(currentInput[firstNonZeroValue...])
//        }
//    }
//    
//    func pressedNumber(_ val: String) {
//        let lastInputWasOperator = operatorList.contains(where: {$0 == currentInput})
////        let noActionSelected = (action == .none)
//        let justCalledEquals = currentInput == "="
//        
//        if lastInputWasOperator {
//            currentInput = "0"
//        }
//        if justCalledEquals {
//            cumulativeResult = "0"
//            currentInput = "0"
//        }
//        
//        currentInput.append(val)
//    }
//    
//    func pressedOperator(_ newAction: OperatorAction) {
//        let currentInputIsNumericString = !currentInput.isEmpty && !operatorList.contains(where: {$0 == currentInput})
//        
//        if currentInputIsNumericString /*&& hasOperand*/ {
//            if cumulativeResult == "0" || action == .none {
//                cumulativeResult = currentInput // assign first operand
//            } else {
//                // calculate
//                cumulativeResult = String(doMath(action: action, operandA: Double(cumulativeResult) ?? 0, operandB: (Double(currentInput) ?? 0)))
//            }
//        }
//
//        self.action = newAction
//        currentInput = newAction.toString()
//    }
//    
//    func pressedSpecialOperator(_ newAction: OperatorAction) {
//        let currentInputIsNumericString = !currentInput.isEmpty && !operatorList.contains(where: {$0 == currentInput})
//        
//        if currentInputIsNumericString /*&& hasOperand*/ {
//            if cumulativeResult == "0" || action == .none {
//                cumulativeResult = currentInput // assign first operand
//            } else {
//                // calculate
//                cumulativeResult = String(doMath(action: action, operandA: Double(cumulativeResult) ?? 0))
//            }
//        }
//
//        self.action = newAction
//        currentInput = newAction.toString()
//    }
//    
//    func allClear() {
//        currentInput = ""
//        cumulativeResult = "0"
//    }
//    
    // called on equals
//    func calculate() {
//        guard action != .none else { return }
//        
//        cumulativeResult = String(doMath(action: action, operandA: Double(cumulativeResult) ?? 0, operandB: (Double(currentInput) ?? 0)))
//        currentInput = cumulativeResult
//        action = .equals
//    }
//}

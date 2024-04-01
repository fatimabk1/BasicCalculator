//
//  CalculatorViewModel.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/29/24.
//

import Foundation
import SwiftUI


final class CalculatorViewModel: ObservableObject {
    @Published var display = ""
    var operationQueue = OperationQueue()
    var newCalculation = true
    var hasError = false
    
    
    
    func updateDisplay() {
        if hasError {
            display = "ERR"
        } else {
            display = operationQueue.lastInputValue
        }
    }
    
    func hasError(_ input: String) -> Bool {
        return input == "ERR"
    }
    
    func setError() {
        hasError = true
        newCalculation = true
    }
    
    func allClear() {
        operationQueue.resetCalculation()
        newCalculation = true
        hasError = false
        print("Cleared queue")
        updateDisplay()
    }
    
    /*
     
     hasError = false
     newCalculation = false
     
     func gotInput(_ input: String) {
        GOT NUMBER
            if prev is Err
                replace
                return
            if new calcuation
                push input
                newCalculation = false
            else
                if prev is number
                    if number is decimal and input is decimal
                        ignore
                    else
                        append input
                else
                    push input
     
        GOT OPERATOR
            if prev is operator
                replace with input (pop, push) -- if this is unary operator, evaluate immediately
                compute
            else
                if canCompute --> check not error
                    compute, clear, push result
                if no error
                    push input [- / sin]
                if canCompute
                    compute, clear, push result
        update display
     
     */
    
    func computeAndUpdate() {
        let result = operationQueue.compute(onError: setError)
        operationQueue.clear()
        operationQueue.push(result)
    }
    
    // TODO: 6 * 2.5 + sin
    // TODO: 0 / 0 SIN
    func gotInput(_ input: String) {
        print("\nOperationQueue: \(operationQueue.toString()), Input: \(input)")
        
        if input.isOperand() {
            if hasError {
                operationQueue.replace(input)
                hasError = false
                newCalculation = false
            } else if newCalculation {
                print("\t got number, new calculation")
                if operationQueue.peek().isOperand() {
                    operationQueue.replace(input)
                } else {
                    operationQueue.push(input)
                }
                newCalculation = false
            } else {
                print("\t got number, continuing calculation")
                if operationQueue.peek().isOperand(){
                    if operationQueue.peek().contains(".") && input == "."{
                        return
                    } else {
                        operationQueue.appendToLast(input)
                        print("\t appending to current value")
                    }
                } else {
                    operationQueue.push(input)
                    print("\t pushing new value")
                }
            }
        } else if input.isOperator() {
            print("\t got operator")
            
            if operationQueue.peek().isOperator() {
                operationQueue.replace(input)
                if operationQueue.canCompute() {
                    computeAndUpdate()
                }
            } else {
                if operationQueue.canCompute() {
                    computeAndUpdate()
                }
                if !hasError {
                    operationQueue.push(input)
                }
                if operationQueue.canCompute() {
                    computeAndUpdate()
                }
            }
        }
        print("OperationQueue: \(operationQueue.toString())\n")
        updateDisplay()
    }
    
    func pressedEquals() {
        if hasError { return }
        let result = operationQueue.computeEquals(onError: setError)
        operationQueue.clear()
        operationQueue.push(result)
        newCalculation = true
        print("calcuating result - called equals")
        print("OperationQueue: \(operationQueue.toString())")
        updateDisplay()
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
//            else
    //            if queue contains binary & have args [isComputable()]
    //                compute,
    //                clear
    //                push result
    //                newCalculation = true
    //                if !hasError
    //                      push op
    //            if newOp is unary w/arg
    //                if hasError { return } -- dont compute with err
    //                push input,
    //                compute
    //                clear
    //                push result
    //                newCalculation = true
    //            if !computable && !unaryOperator && !hasError
    //                push op
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

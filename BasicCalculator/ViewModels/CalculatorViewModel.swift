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
        updateDisplay()
    }

    func computeAndUpdate() {
        let result = operationQueue.compute(onError: setError)
        operationQueue.clear()
        operationQueue.push(result)
    }
    
    func handleOperand(_ input: String) {
        if hasError {
            operationQueue.replace(input)
            hasError = false
            newCalculation = false
            return
        }
        
        if newCalculation {
            if operationQueue.peek().isOperand() {
                operationQueue.replace(input)
            } else {
                operationQueue.push(input)
            }
            newCalculation = false
            return
        }
        
        if operationQueue.peek().isOperand(){
            if operationQueue.peek().contains(".") && input == "." {
                return
            }
            operationQueue.appendToLast(input)
        } else {
            operationQueue.push(input)
        }
    }
    
    func handleOperator(_ input: String) {
        if operationQueue.peek().isOperator() {
            operationQueue.replace(input)
            if operationQueue.canCompute {
                computeAndUpdate()
            }
        } else {
            if operationQueue.canCompute {
                computeAndUpdate()
            }
            if !hasError {
                operationQueue.push(input)
            }
            if operationQueue.canCompute {
                computeAndUpdate()
            }
        }
    }
    
    func gotInput(_ input: String) {
        if input.isOperand() {
            handleOperand(input)
        } else if input.isOperator() {
            handleOperator(input)
        }
        updateDisplay()
    }
    
    func pressedEquals() {
        if hasError { return }
        let result = operationQueue.computeEquals()
        switch result {
        case let .success(result):
            operationQueue.clear()
            operationQueue.push(result)
            newCalculation = true
        case .failure:
            setError()
        }
        updateDisplay()
    }
}

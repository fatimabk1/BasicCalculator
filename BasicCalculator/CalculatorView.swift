//
//  CalculatorView.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/29/24.
//

import SwiftUI

/*
 TEST CASES:
 
Operator, Operand
 * 1                0 (*)
 + 5                5 (+)
 
 Operator, Operand, Operand, Operand, Operator
 + 435 -            435 (+/-)
 
Operator, Operator, equals
 + - =              0 (+/-/=)
 
Operator, operator, operand
 + - 5 =            -5 (+/-)
 
 Operand
 5 =                5
 5 + =              5
 5 + = = =          5
 2 + 2 - 3          4, 1
 
Errors
 / 0                ERR
 / 0 +              Err
 / 0 + 6            Err
 / 0 + 6 - 3 =      3 (6-3)
 / 0 Sin            Err
 / 0 Sin Sin        Err
 
 Decimals
 2.....5            2.5
 0.2 =              0.2
 2.500000            2.5
 0.0                0

 */


struct CalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    init() {
        self.viewModel = CalculatorViewModel()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.operationQueue.toString())
            Text(viewModel.operationQueue.lastInputValue)
                .font(.title)
                .padding(.horizontal, 50)
                .frame(maxWidth: .infinity, alignment: .trailing)
            ButtonGrid(pressInput: viewModel.gotInput, pressEquals: viewModel.pressedEquals, pressClear: viewModel.allClear)
        }
        .padding()
    }
}

struct ButtonGrid: View {
    let columns = [GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50))]
    let pressInput: (String) -> Void
    let pressEquals: () -> Void
    let pressClear: () -> Void
    
    var body: some View {
        LazyVGrid(columns: columns, content: {
            
            CalculatorButton(value: "7", isOperator: false) { pressInput("7") }
            CalculatorButton(value: "8", isOperator: false) { pressInput("8") }
            CalculatorButton(value: "9", isOperator: false) { pressInput("9") }
            CalculatorButton(value: "/", isOperator: true) { pressInput("/") }
            
            CalculatorButton(value: "4", isOperator: false) { pressInput("4") }
            CalculatorButton(value: "5", isOperator: false) { pressInput("5") }
            CalculatorButton(value: "6", isOperator: false) { pressInput("6") }
            CalculatorButton(value: "x", isOperator: true) { pressInput("x") }
            
            CalculatorButton(value: "1", isOperator: false) { pressInput("1") }
            CalculatorButton(value: "2", isOperator: false) { pressInput("2") }
            CalculatorButton(value: "3", isOperator: false) { pressInput("3") }
            CalculatorButton(value: "-", isOperator: true) { pressInput("-") }
            
            CalculatorButton(value: "0", isOperator: false) { pressInput("0") }
            CalculatorButton(value: ".", isOperator: false) { pressInput(".") }
            CalculatorButton(value: "AC", isOperator: true) { pressClear() }
            CalculatorButton(value: "+", isOperator: true) { pressInput("+") }
            
            CalculatorButton(value: "Sin", isOperator: true) { pressInput("Sin") }
            CalculatorButton(value: "Cos", isOperator: true) { pressInput("Cos") }
            CalculatorButton(value: "Tan", isOperator: true) { pressInput("Tan") }
            CalculatorButton(value: "=", isOperator: true) { pressEquals() }
        })
    }
}



#Preview {
    CalculatorView()
}

//
//  CalculatorView.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/29/24.
//

import SwiftUI

struct CalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    let columns = [GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50)), GridItem(.flexible(minimum: 50))]
    
    init() {
        self.viewModel = CalculatorViewModel()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.cumulativeResult)
                .font(.title)
                .padding(.horizontal, 50)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text(viewModel.display)
                .font(.title)
                .padding(.horizontal, 50)
                .frame(maxWidth: .infinity, alignment: .trailing)
            LazyVGrid(columns: columns, content: {
                
                OperandButton(value: "7") { viewModel.pressedNumber("7") }
                OperandButton(value: "8") { viewModel.pressedNumber("8") }
                OperandButton(value: "9") { viewModel.pressedNumber("9") }
                OperatorButton(value: "/") { viewModel.pressedOperator(.divide) }
                
                OperandButton(value: "4") { viewModel.pressedNumber("4") }
                OperandButton(value: "5") { viewModel.pressedNumber("5") }
                OperandButton(value: "6") { viewModel.pressedNumber("6") }
                OperatorButton(value: "x") { viewModel.pressedOperator(.multiply) }
                
                OperandButton(value: "1") { viewModel.pressedNumber("1") }
                OperandButton(value: "2") { viewModel.pressedNumber("2") }
                OperandButton(value: "3") { viewModel.pressedNumber("3") }
                OperatorButton(value: "-") { viewModel.pressedOperator(.subtract) }
                
                OperandButton(value: "0") { viewModel.pressedNumber("0") }
//                OperandButton(value: ".") { viewModel.pressedNumber(".") }
                OperatorButton(value: "AC") { viewModel.allClear() }
                OperatorButton(value: "+") { viewModel.pressedOperator(.add) }
                OperatorButton(value: "=") { viewModel.calculate() }
                
                OperatorButton(value: "Sin") { viewModel.pressedOperator(.sin) }
                OperatorButton(value: "Cos") { viewModel.pressedOperator(.cos) }
                OperatorButton(value: "Tan") { viewModel.pressedOperator(.tan) }
            })
        }
        .padding()
    }
}

struct OperatorButton: View {
    let value: String
    let onButtonPress: () -> Void
    
    var body: some View {
        Button {
            onButtonPress()
        } label: {
            Text(value)
                .font(.title2)
                .frame(width: 75, height: 75)
                .background(.orange.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}


struct OperandButton: View {
    let value: String
    let onButtonPress: () -> Void
    
    var body: some View {
        Button {
            onButtonPress()
        } label: {
            Text(value)
                .font(.title2)
                .frame(width: 75, height: 75)
                .background(.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}



#Preview {
    CalculatorView()
}

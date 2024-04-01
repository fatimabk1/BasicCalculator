//
//  ButtonGrid.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 4/1/24.
//

import SwiftUI

struct ButtonGrid: View {
    @State var selectedButton = ""
    let columns = [GridItem(.flexible(minimum: 50)),
                   GridItem(.flexible(minimum: 50)),
                   GridItem(.flexible(minimum: 50)),
                   GridItem(.flexible(minimum: 50))]
    let pressInput: (String) -> Void
    let pressEquals: () -> Void
    let pressClear: () -> Void
    let geo: GeometryProxy
    
    
    
    var body: some View {
        
        let isLandscape = geo.size.width > geo.size.height
        let idealSize = isLandscape ? geo.size.width / 14 - 10 : geo.size.width / 4 - 10
//            let idealSize = geo.size.width / 4 - 10
        LazyVGrid(columns: columns, content: {
            CalculatorButton(value: "7", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("7") }
            CalculatorButton(value: "8", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("8") }
            CalculatorButton(value: "9", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("9") }
            CalculatorButton(value: "/", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("/") }
            
            CalculatorButton(value: "4", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("4") }
            CalculatorButton(value: "5", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("5") }
            CalculatorButton(value: "6", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("6") }
            CalculatorButton(value: "x", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("x") }
            
            CalculatorButton(value: "1", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("1") }
            CalculatorButton(value: "2", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("2") }
            CalculatorButton(value: "3", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("3") }
            CalculatorButton(value: "-", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("-") }
            
            CalculatorButton(value: "0", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("0") }
            CalculatorButton(value: ".", isOperator: false, selectedButton: $selectedButton, idealSize: idealSize) { pressInput(".") }
            CalculatorButton(value: "AC", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressClear() }
            CalculatorButton(value: "+", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("+") }
            
            CalculatorButton(value: "Sin", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("Sin") }
            CalculatorButton(value: "Cos", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("Cos") }
            CalculatorButton(value: "Tan", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressInput("Tan") }
            CalculatorButton(value: "=", isOperator: true, selectedButton: $selectedButton, idealSize: idealSize) { pressEquals() }
        })
    }
}

#Preview {
    GeometryReader { geo in
        ButtonGrid(pressInput: {_ in }, pressEquals: {}, pressClear: {}, geo: geo)
    }
}

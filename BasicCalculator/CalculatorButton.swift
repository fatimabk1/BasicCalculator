//
//  CalculatorButton.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/31/24.
//

import SwiftUI

struct CalculatorButton: View {
    let value: String
    let isOperator: Bool
    @Binding var selectedButton: String
    let idealSize: CGFloat
    let onButtonPress: () -> Void
    
    
    var body: some View {
        let opacity = isOperator && selectedButton == value ? 1 : 0.7
        Button {
            onButtonPress()
            selectedButton = value
        } label: {
            Text(value)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(idealWidth: idealSize, /*idealWidth: 75,*/ idealHeight: idealSize/*, idealHeight: 75*/)
                .background((isOperator ? Color.orange : Color.blue)
                    .opacity(opacity))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    return Group {
        CalculatorButton(value: "7", isOperator: false, selectedButton: .constant("7"), idealSize: 75, onButtonPress: {})
        CalculatorButton(value: "8", isOperator: false, selectedButton: .constant("7"), idealSize: 75, onButtonPress: {})
        CalculatorButton(value: "AC", isOperator: true, selectedButton: .constant("AC"), idealSize: 75, onButtonPress: {})
        CalculatorButton(value: "=", isOperator: true, selectedButton: .constant("AC"), idealSize: 75, onButtonPress: {})
    }
}

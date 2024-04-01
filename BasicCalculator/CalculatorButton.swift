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
    let onButtonPress: () -> Void
    
    var body: some View {
        Button {
            onButtonPress()
        } label: {
            Text(value)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 75, height: 75)
                .background((isOperator ? Color.orange : Color.blue).opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    return Group {
        CalculatorButton(value: "7", isOperator: false, onButtonPress: {})
        CalculatorButton(value: "AC", isOperator: true, onButtonPress: {})
    }
}

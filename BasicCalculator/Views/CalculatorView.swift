//
//  CalculatorView.swift
//  BasicCalculator
//
//  Created by Fatima Kahbi on 3/29/24.
//

import SwiftUI


struct CalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    init() {
        self.viewModel = CalculatorViewModel()
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                Text(viewModel.operationQueue.lastInputValue)
                    .font(.title)
                    .padding(.horizontal, 50)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                ButtonGrid(pressInput: viewModel.gotInput, pressEquals: viewModel.pressedEquals, pressClear: viewModel.allClear, geo: geo)
                    .padding(.bottom)
                    .padding(.horizontal)
            }
        }
    }
}





#Preview {
    CalculatorView()
}

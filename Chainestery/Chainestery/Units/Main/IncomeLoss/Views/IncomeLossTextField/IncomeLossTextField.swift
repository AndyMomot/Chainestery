//
//  IncomeLossTextField.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI

struct IncomeLossTextField: View {
    var day: String
    @Binding var income: String
    @Binding var loss: String
    var onChange: (IncomeLossView.IncomeLossDataModel) -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text(day)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 20))
                    .padding(.leading)
                
                Rectangle()
                    .foregroundStyle(.black)
                    .frame(height: 2)
            }
            
            
            HStack {
                TextField("", text: $income)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .font(Fonts.KulimPark.light.swiftUIFont(size: 15))
                    .keyboardType(.numberPad)
                
                Spacer()
                Rectangle()
                    .foregroundStyle(Colors.slateGray.swiftUIColor)
                    .frame(width: 1)
                    .padding(.vertical, 1)
                Spacer()
                
                TextField("", text: $loss)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .font(Fonts.KulimPark.light.swiftUIFont(size: 15))
                    .keyboardType(.numberPad)
            }
            .padding(10)
            .background(.white)
            .cornerRadius(10, corners: .allCorners)
        }
        .onChange(of: income) { _ in
            let model = createDataModel()
            onChange(model)
        }
        .onChange(of: loss) { _ in
            let model = createDataModel()
            onChange(model)
        }
    }
}

private extension IncomeLossTextField {
    func createDataModel() -> IncomeLossView.IncomeLossDataModel {
        let day = IncomeLossView.Day(rawValue: self.day) ?? .monday
        let income = Int(self.income) ?? .zero
        let loss = Int(self.loss) ?? .zero
        return .init(day: day, income: income, loss: loss)
    }
}

#Preview {
    ZStack {
        Colors.silverGray.swiftUIColor
        IncomeLossTextField(day: "ПН", income: .constant("133"),
                            loss: .constant("50")) { _ in }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

//
//  IncomeLossTextField.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI

struct IncomeLossTextField: View {
    var title: String
    @Binding var income: String
    @Binding var loss: String
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text(title)
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
    }
}

#Preview {
    ZStack {
        Colors.silverGray.swiftUIColor
        IncomeLossTextField(title: "ПН", income: .constant("133"),
                            loss: .constant("50"))
        .frame(height: 40)
        .padding(.horizontal)
    }
}

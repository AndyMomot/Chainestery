//
//  DynamicHeightTextField.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import SwiftUI

struct DynamicHeightTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 11)
                    .foregroundStyle(.white)
                
                TextEditor(text: $text)
                    .foregroundStyle(.black)
                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 17))
                    .background(.white)
                    .padding()
                
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(Colors.slateGray.swiftUIColor)
                        .font(Fonts.KulimPark.light.swiftUIFont(size: 13))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 26)
                        .allowsHitTesting(false)
                }
            }
            .cornerRadius(11, corners: .allCorners)
    }
}

#Preview {
    ZStack {
        Colors.deepTeal.swiftUIColor
        DynamicHeightTextField(
            placeholder: "Введите информацию",
            text: .constant(""))
            .frame(maxHeight: 170)
            .padding()
    }
}

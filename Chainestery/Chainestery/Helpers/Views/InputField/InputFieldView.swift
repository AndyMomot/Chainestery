//
//  InputFieldView.swift
//  Chainestery
//
//  Created by Andrii Momot on 18.08.2024.
//

import SwiftUI

struct InputFieldView: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundStyle(.white.opacity(0.6))
                .font(Fonts.KulimPark.light.swiftUIFont(size: 13))
            
            TextField(text: $text) {
                Text(title)
                    .foregroundStyle(Colors.slateGray.swiftUIColor)
                    .font(Fonts.KulimPark.light.swiftUIFont(size: 13))
            }
            .foregroundStyle(.black)
            .font(Fonts.KulimPark.bold.swiftUIFont(size: 17))
            .padding()
            .background(.white)
            .cornerRadius(10, corners: .allCorners)
        }
    }
}

#Preview {
    ZStack {
        Colors.deepTeal.swiftUIColor
            .ignoresSafeArea()
        InputFieldView(title: "ФИО", text: .constant(""))
            .padding()
    }
}

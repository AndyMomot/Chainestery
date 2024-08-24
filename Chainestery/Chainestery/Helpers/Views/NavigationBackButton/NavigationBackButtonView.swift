//
//  NavigationBackButtonView.swift
//  Chainestery
//
//  Created by Andrii Momot on 18.08.2024.
//

import SwiftUI

struct NavigationBackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    var title: String
    var color: Color
    
    var body: some View {
        HStack {
            Button {
                dismiss.callAsFunction()
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .foregroundStyle(color)
                    .font(Fonts.KulimPark.semiBold.swiftUIFont(size: 30))
            }

            Spacer(minLength: 20)
            
            Text(title)
                .foregroundStyle(color)
                .font(Fonts.KulimPark.bold.swiftUIFont(size: 30))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
}

#Preview {
    NavigationBackButtonView(title: "Back", color: .black)
        .padding(.horizontal)
}


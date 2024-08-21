//
//  CustomAlertView.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import SwiftUI

struct CustomAlertView: View {
    var title: String
    var action: (Bool) -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                Spacer()
            }
            
            Rectangle()
                .foregroundStyle(Colors.silverGray.swiftUIColor)
                .frame(height: 2)
            
            HStack(spacing: 22) {
                Button {
                    action(true)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.white)
                            .frame(width: 120, height: 44)
                        
                        Text("Да")
                            .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                            .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                    }
                }

                Button {
                    action(false)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Colors.darkGrayCustom.swiftUIColor)
                            .frame(width: 120, height: 44)
                        
                        Text("Нет")
                            .foregroundStyle(.white)
                            .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                    }
                }
            }
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 40)
        .background(Colors.emeraldSurge.swiftUIColor)
        .cornerRadius(18, corners: .allCorners)
    }
}

#Preview {
    CustomAlertView(title: "Вы хотите удалить ?") { _ in }
        .padding()
}

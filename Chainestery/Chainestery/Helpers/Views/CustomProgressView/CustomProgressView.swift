//
//  CustomProgressView.swift
//  Chainestery
//
//  Created by Andrii Momot on 18.08.2024.
//

import SwiftUI

struct CustomProgressView: View {
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: geometry.size.width, height: 15)
                    .foregroundColor(Colors.silverGray.swiftUIColor)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(
                        width: min((progress * geometry.size.width) - 10,
                                   geometry.size.width),
                        height: 11
                    )
                    .foregroundColor(Colors.redC.swiftUIColor)
                    .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    ZStack {
        Colors.deepTeal.swiftUIColor
        CustomProgressView(progress: 1)
            .padding()
    }
}

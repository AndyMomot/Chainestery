//
//  HomeButtonView.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import SwiftUI

struct HomeButtonView: View {
    
    var imageName: String
    var onTap: () -> Void
    
    @Environment(\.isEnabled) var isEnabled
    
    var body: some View {
        Button {
            onTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Colors.silverGray.swiftUIColor, Colors.redC.swiftUIColor)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
        }
    }
}

#Preview {
    HomeButtonView(imageName: Asset.employers.name) {
        
    }
}

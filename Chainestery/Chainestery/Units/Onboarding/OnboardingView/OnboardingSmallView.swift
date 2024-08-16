//
//  OnboardingSmallView.swift

import SwiftUI

struct OnboardingSmallView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Colors.deepTeal.swiftUIColor)
                .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
            
            VStack(spacing: 18) {
                Asset.logo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 43)
                    .padding(.top)
                
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                
                Text(item.text)
                    .foregroundStyle(.white)
                    .font(Fonts.KulimPark.regular.swiftUIFont(size: 15))
                    .padding(.horizontal, 9)
                
                Spacer()
                
                let arrange = Array(0..<item.count)
                HStack(spacing: 20) {
                    Spacer()
                    ForEach(arrange, id: \.self) { index in
                        let isCurrent = index == currentPageIndex
                        
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 38, height: 6)
                            .foregroundStyle(
                                isCurrent ?  Colors.redC.swiftUIColor : Colors.silverGray.swiftUIColor
                            )
                    }
                    Spacer()
                }
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    ZStack {
        Colors.silverGray.swiftUIColor
        
        OnboardingSmallView(item: .second,
                            currentPageIndex: .constant(1))
            .frame(width: 300, height: 490)
    }
}

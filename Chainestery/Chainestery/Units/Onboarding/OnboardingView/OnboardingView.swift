//
//  OnboardingView.swift

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.silverGray.swiftUIColor.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 100) {
                HStack {
                    Text(item.title)
                        .foregroundStyle(Colors.deepTeal.swiftUIColor)
                        .font(Fonts.KulimPark.bold.swiftUIFont(size: 40))
                        .padding(.horizontal)
                    Spacer()
                }
                
                VStack(spacing: 38) {
                    OnboardingSmallView(item: item,
                                        currentPageIndex: $currentPageIndex)
                    .padding(.horizontal, 61)
                    
                    HStack(spacing: 60) {
                        Button {
                            withAnimation {
                                currentPageIndex = item.previews.rawValue
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.black)
                        }

                        Button {
                            withAnimation {
                                currentPageIndex = item.next.rawValue
                            }
                        } label: {
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Colors.redC.swiftUIColor)
                        }
                    }
                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 30))
                }
                
                Spacer()
            }
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    OnboardingView(item: .second, currentPageIndex: .constant(1))
}

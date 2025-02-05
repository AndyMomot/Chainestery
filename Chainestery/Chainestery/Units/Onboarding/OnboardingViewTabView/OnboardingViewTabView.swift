//
//  OnboardingViewTabView.swift

import SwiftUI

struct OnboardingViewTabView: View {
    @State private var currentPageIndex = 0
    
    var body: some View {
        TabView(selection: $currentPageIndex) {
            OnboardingView(item: .first, currentPageIndex: $currentPageIndex)
                .tag(0)
            
            OnboardingView(item: .second, currentPageIndex: $currentPageIndex)
                .tag(1)
            
            OnboardingView(item: .third, currentPageIndex: $currentPageIndex)
                .tag(2)
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

#Preview {
    OnboardingViewTabView()
}

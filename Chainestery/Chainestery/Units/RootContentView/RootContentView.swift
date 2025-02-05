//
//  RootContentView.swift
//  Tradifundint
//
//  Created by Andrii Momot on 07.07.2024.
//

import SwiftUI

struct RootContentView: View {
    @StateObject private var viewModel = RootContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.showPreloader {
                PreloaderView()
            } else {
                switch viewModel.viewState {
                case .onboarding:
                    OnboardingViewTabView()
                        .environmentObject(viewModel)
                case .privacy:
                    PrivacyPolicyView()
                        .environmentObject(viewModel)
                case .main:
                    HomeView()
                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear {
            withAnimation {
                self.viewModel.getFlow()
            }
        }
    }
}

#Preview {
    RootContentView()
}

//
//  PreloaderView.swift
//  Chainestery
//
//  Created by Andrii Momot on 16.08.2024.
//

import SwiftUI

struct PreloaderView: View {
    @StateObject private var viewModel = PreloaderViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    Asset.logo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 150)
                    
                    Asset.logoName.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 67)
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    CustomProgressView(progress: viewModel.progress)
                        .frame(height: 15)
                        .padding(.horizontal, 110)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Text(viewModel.progressString)
                            .foregroundStyle(.white)
                            .font(Fonts.KulimPark.regular.swiftUIFont(size: 24))
                        Text("....")
                            .foregroundStyle(Colors.redC.swiftUIColor)
                            .font(Fonts.KulimPark.regular.swiftUIFont(size: 24))
                    }
                }
                
                Spacer()
            }
            .padding(.top)
        }
        .onReceive(viewModel.timer) { input in
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.updateProgress()
                }
            }
        }
    }
}

#Preview {
    PreloaderView()
}

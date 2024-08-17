//
//  PrivacyPolicyView.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    @StateObject private var viewModel = PrivacyPolicyViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
            
            VStack {
                Rectangle()
                    .cornerRadius(80, corners: [.bottomLeft,
                                                .bottomRight])
                    .ignoresSafeArea(edges: .top)
                    .foregroundStyle(Colors.silverGray.swiftUIColor)
                    .frame(height: bounds.height * 0.5)
                
                Spacer()
            }
            
            VStack(spacing: 40) {
                VStack(spacing: 10) {
                    Asset.logo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, bounds.width * 0.4)
                        
                    Text("chainestery")
                        .foregroundStyle(Colors.deepTeal.swiftUIColor)
                        .font(Fonts.KulimPark.regular.swiftUIFont(size: 24))
                        .multilineTextAlignment(.center)
                }
                .padding(.top)
                
                Asset.privacyIcon.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, bounds.width * 0.1)
                
                Button {
                    viewModel.showPrivacyFlow(rootViewModel: rootViewModel)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.white)
                            .frame(height: 44)
                            .padding(.horizontal, bounds.width * 0.22)
                        
                        Text("Приступить")
                            .foregroundStyle(Colors.ceruleanBlue.swiftUIColor)
                            .font(Fonts.KulimPark.bold.swiftUIFont(size: 20))
                            .multilineTextAlignment(.center)
                    }
                }
                .opacity(viewModel.isAgreed ? 1 : 0.5)
                .disabled(!viewModel.isAgreed)
                
                HStack(spacing: 14) {
                    Button {
                        withAnimation {
                            viewModel.isAgreed.toggle()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundStyle(
                                    viewModel.isAgreed ? Colors.emeraldSurge.swiftUIColor : Colors.redC.swiftUIColor
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .stroke(.white, lineWidth: 1)
                                }
                            
                            RoundedRectangle(cornerRadius: 4)
                                .scaledToFit()
                                .frame(width: 16)
                                .foregroundStyle(Colors.slateGray.swiftUIColor)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .stroke(.white, lineWidth: 1)
                                }
                        }
                        
                        if viewModel.isAgreed {
                           EmptyView()
                        } else {
                            EmptyView()
                        }
                    }

                    Text("Вы даёте своё согласие на обработку персональных данных.")
                        .foregroundStyle(.white)
                        .font(Fonts.KulimPark.regular.swiftUIFont(size: 15))
                }
                .padding(.horizontal, bounds.width * 0.14)
                
                Spacer()
            }
        }
    }
}

#Preview {
    PrivacyPolicyView()
}

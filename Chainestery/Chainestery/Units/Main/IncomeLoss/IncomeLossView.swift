//
//  IncomeLossView.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI

struct IncomeLossView: View {
    @StateObject private var viewModel = IncomeLossViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
                .opacity(0.2)
            
            Asset.repairBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
                .opacity(0.2)
            
            VStack(spacing: bounds.height * 0.05) {
                NavigationBackButtonView(
                    title: "ДОХОД/УБЫТОК",
                    color: Colors.deepTeal.swiftUIColor)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 24) {
                        ChartView(data: viewModel.data) {
                            
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Spacer()
                                
                                HStack(spacing: 40) {
                                    HStack(spacing: 8) {
                                        RoundedRectangle(cornerRadius: 5)
                                            .scaledToFit()
                                            .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                                            .frame(width: 13)
                                        
                                        Text("Доход")
                                            .foregroundStyle(.black)
                                            .font(Fonts.KulimPark.light.swiftUIFont(size: 10))
                                    }
                                    
                                    HStack(spacing: 8) {
                                        RoundedRectangle(cornerRadius: 5)
                                            .scaledToFit()
                                            .foregroundStyle(Colors.redC.swiftUIColor)
                                            .frame(width: 13)
                                        
                                        Text("Убыток")
                                            .foregroundStyle(.black)
                                            .font(Fonts.KulimPark.light.swiftUIFont(size: 10))
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            IncomeLossTextField(
                                title: "ПН",
                                income: $viewModel.mondayIncome,
                                loss: $viewModel.mondayLoss)
                        }
                        .padding(.horizontal)
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    IncomeLossView()
}

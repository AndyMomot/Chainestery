//
//  HomeView.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = HomeViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors.deepTeal.swiftUIColor
                    .ignoresSafeArea()
                
                Asset.homeBackground.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.15)
                
                VStack(spacing: bounds.height * 0.1) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("ЗДРАВСТВУЙТЕ !")
                                .foregroundStyle(Colors.redC.swiftUIColor)
                            
                            Text("ВЫ В ГЛАВНОМ МЕНЮ")
                                .foregroundStyle(Colors.silverGray.swiftUIColor)
                        }
                        .font(Fonts.KulimPark.bold.swiftUIFont(size: 30))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: bounds.height * 0.07) {
                        let buttonWidth = bounds.width * 0.26
                        HStack {
                            HomeButtonView(imageName: Asset.employers.name) {
                                viewModel.showEmployers.toggle()
                            }
                            .frame(width: buttonWidth,
                                   height: buttonWidth)
                            
                            Spacer()
                            
                            HomeButtonView(imageName: Asset.createOrder.name) {
                                viewModel.showOrders.toggle()
                            }
                            .frame(width: buttonWidth,
                                   height: buttonWidth)
                        }
                        
                        HomeButtonView(imageName: Asset.statistic.name) {
                            
                        }
                        .frame(height: buttonWidth)
                        
                        HomeButtonView(imageName: Asset.notes.name) {
                            viewModel.showNotes.toggle()
                        }
                        .frame(height: buttonWidth)
                    }
                    .padding(.horizontal, bounds.width * 0.14)
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $viewModel.showEmployers) {
                EmployersView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $viewModel.showOrders) {
                OrdersView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $viewModel.showNotes) {
                OrderNotesView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    HomeView()
}

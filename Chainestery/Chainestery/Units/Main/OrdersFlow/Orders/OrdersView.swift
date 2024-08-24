//
//  OrdersView.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import SwiftUI

struct OrdersView: View {
    
    @StateObject private var viewModel = OrdersViewModel()
    
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
            
            VStack(spacing: bounds.height * 0.07) {
                NavigationBackButtonView(
                    title: "РЕМОНТ ТЕХНИКИ",
                    color: Colors.deepTeal.swiftUIColor)
                .padding(.horizontal)
                
                if viewModel.isHaveCompletedOrders {
                    Button {
                        viewModel.showCompletedOrders.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .font(Fonts.KulimPark.bold.swiftUIFont(size: 30))
                                .frame(height: 20)
                            Spacer()
                        }
                        .padding(.vertical)
                        .background(Colors.emeraldSurge.swiftUIColor)
                        .cornerRadius(14, corners: .allCorners)
                    }
                    .padding(.horizontal)
                }
                
                ScrollView {
                    VStack(spacing: 17) {
                        ForEach(viewModel.orders) { order in
                            Button {
                                viewModel.orderToShow = order
                                viewModel.showOrderDetails.toggle()
                            } label: {
                                OrderCell(item: order)
                            }
                        }
                        
                        Button {
                            viewModel.showAddOrder.toggle()
                        } label: {
                            HStack {
                                Spacer()
                                Asset.plus.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: bounds.width * 0.1)
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .background(Colors.deepTeal.swiftUIColor)
                            .cornerRadius(14, corners: .allCorners)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
            }
        }
        .onAppear {
            withAnimation {
                viewModel.getOrders()
            }
        }
        .navigationDestination(isPresented: $viewModel.showAddOrder) {
            AddOrderView() {
                viewModel.getOrders()
            }
                .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $viewModel.showOrderDetails) {
            if let order = viewModel.orderToShow {
                RepairView(item: order) {
                    withAnimation {
                        viewModel.getOrders()
                    }
                }
                    .navigationBarBackButtonHidden()
            }
        }
        .navigationDestination(isPresented: $viewModel.showCompletedOrders) {
            FinishedOrdersView {
                withAnimation {
                    viewModel.getOrders()
                }
            }
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    OrdersView()
}

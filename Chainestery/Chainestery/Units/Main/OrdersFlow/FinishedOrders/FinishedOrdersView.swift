//
//  FinishedOrdersView.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI

struct FinishedOrdersView: View {
    
    @StateObject private var viewModel = FinishedOrdersViewModel()
    var onDelete: () -> Void
    
    
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
                    title: "ЗАВЕРШЕННО",
                    color: Colors.deepTeal.swiftUIColor)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 17) {
                        ForEach(viewModel.orders) { order in
                            HStack(spacing: 20) {
                                OrderCell(item: order)
                                
                                Button {
                                    withAnimation {
                                        viewModel.showDeleteAlert.toggle()
                                    }
                                    viewModel.orderToDelete = order
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .foregroundStyle(Colors.redC.swiftUIColor)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
            }
            
            if viewModel.showDeleteAlert {
                Color.white.opacity(0.6)
                    .ignoresSafeArea()
                
                CustomAlertView(title: "Вы хотите удалить ?") { flag in
                    viewModel.showDeleteAlert.toggle()
                    
                    if flag {
                        viewModel.removeOrder()
                        onDelete()
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            withAnimation {
                viewModel.getOrders()
            }
        }
    }
}

#Preview {
    FinishedOrdersView(){}
}

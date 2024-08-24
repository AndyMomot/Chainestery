//
//  OrderNotesView.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI

struct OrderNotesView: View {
    @StateObject private var viewModel = OrderNotesViewModel()
    
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
                    title: "ЗАМЕТКИ ЗАКАЗОВ",
                    color: Colors.deepTeal.swiftUIColor)
                .padding(.horizontal)
                
                HStack {
                    TextField(text: $viewModel.searchText) {
                        Text("введите имя ")
                            .foregroundStyle(Colors.slateGray.swiftUIColor)
                            .font(Fonts.KulimPark.regular.swiftUIFont(size: 18))
                    }
                    .foregroundStyle(.black)
                    .font(Fonts.KulimPark.regular.swiftUIFont(size: 18))
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                        .font(Fonts.KulimPark.regular.swiftUIFont(size: 18))
                }
                .padding()
                .background(.white)
                .cornerRadius(12, corners: .allCorners)
                .shadow(radius: 10)
                
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
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.getOrders()
        }
        .onChange(of: viewModel.searchText) { name in
            viewModel.searchOrders(byName: name)
        }
        .navigationDestination(isPresented: $viewModel.showOrderDetails) {
            if let order = viewModel.orderToShow {
                AddOrderNoteView(item: order)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    OrderNotesView()
}

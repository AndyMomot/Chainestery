//
//  OrdersViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import Foundation

extension OrdersView {
    final class OrdersViewModel: ObservableObject {
        @Published var isHaveCompletedOrders = false
        @Published var orders: [OrderModel] = []
        
        @Published var showCompletedOrders = false
        @Published var showAddOrder = false
        
        @Published var orderToShow: OrderModel?
        @Published var showOrderDetails = false
        
        func getOrders() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                let allOrders = DefaultsService.orders
                self.orders = allOrders.filter { $0.status != .finished }
                self.isHaveCompletedOrders = allOrders.contains(where: { $0.status == .finished })
            }
        }
    }
}

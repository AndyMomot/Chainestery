//
//  FinishedOrdersViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import Foundation

extension FinishedOrdersView {
    final class FinishedOrdersViewModel: ObservableObject {
        @Published var orders: [OrderModel] = []
        @Published var showDeleteAlert = false
        @Published var orderToDelete: OrderModel?
        
        func getOrders() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.orders = DefaultsService.orders.filter { $0.status == .finished }
            }
        }
        
        func removeOrder() {
            guard let orderToDelete else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                DefaultsService.removeOrder(model: orderToDelete)
                self.getOrders()
            }
        }
    }
}

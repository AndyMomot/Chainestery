//
//  OrderNotesViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import Foundation

extension OrderNotesView {
    final class OrderNotesViewModel: ObservableObject {
        @Published var searchText = ""
        @Published var orders: [OrderModel] = []
        
        @Published var orderToShow: OrderModel?
        @Published var showOrderDetails = false
        
        func getOrders() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.orders = DefaultsService.orders
            }
        }
        
        func searchOrders(byName name: String) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if !name.isEmpty {
                    self.orders = DefaultsService.orders.filter { $0.name.localizedCaseInsensitiveContains(name) }
                } else {
                    self.getOrders()
                }
            }
        }
    }
}

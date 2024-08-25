//
//  HomeViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import Foundation

extension HomeView {
    final class HomeViewModel: ObservableObject {
        @Published var showEmployers = false
        @Published var showOrders = false
        @Published var showIncomeLoss = false
        @Published var showNotes = false
    }
}

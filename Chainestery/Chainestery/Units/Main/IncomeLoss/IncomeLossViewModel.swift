//
//  IncomeLossViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import Foundation

extension IncomeLossView {
    final class IncomeLossViewModel: ObservableObject {
        @Published var data: [IncomeLossView.IncomeLossDataModel] = []
    }
}

extension IncomeLossView {
    struct IncomeLossDataModel: Identifiable {
        var id: Int
        var day: String
        var income: Int
        var loss: Int
    }
}

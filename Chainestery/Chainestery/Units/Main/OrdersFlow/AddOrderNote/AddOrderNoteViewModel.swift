//
//  AddOrderNoteViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import Foundation
import SwiftUI

extension AddOrderNoteView {
    final class AddOrderNoteViewModel: ObservableObject {
        @Published var image: Image? = Asset.onboarding1.swiftUIImage
        @Published var text = ""
        
        func saveNote(order: OrderModel, completion: @escaping () -> Void) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                var orderToEdit = order
                orderToEdit.note = self.text
                DefaultsService.editOrder(model: orderToEdit)
                completion()
            }
        }
    }
}

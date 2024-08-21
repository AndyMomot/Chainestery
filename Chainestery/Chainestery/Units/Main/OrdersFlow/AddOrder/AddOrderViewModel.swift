//
//  AddOrderViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import Foundation
import UIKit.UIImage

extension AddOrderView {
    final class AddOrderViewModel: ObservableObject {
        @Published var selectedImage: UIImage = UIImage(systemName: "photo.fill") ?? .init()
        @Published var showImagePicker = false
        @Published var isImageSelected = false
        @Published var name: String = ""
        @Published var budget: String = ""
        @Published var info: String = ""
        
        private var isValidFields: Bool {
            let isValidBudget = (Double(budget) ?? .zero) > .zero
            return isImageSelected && !name.isEmpty && isValidBudget && !info.isEmpty
        }
        
        func createOrder(completion: @escaping () -> Void) {
            DispatchQueue.main.async { [weak self] in
                guard let self, self.isValidFields else { return }
                let model = OrderModel(
                    name: self.name,
                    budget: Double(self.budget) ?? .zero,
                    info: self.info)
                
                DefaultsService.addOrder(model: model)
                
                // Order image saving
                if let imageData = self.selectedImage.jpegData(compressionQuality: 1) {
                    self.saveImage(data: imageData, to: model.id)
                }
                
                completion()
            }
        }
        
        private func saveImage(data: Data, to pathID: String) {
            let path = FileManagerService.Keys.image(id: pathID).path
            FileManagerService().saveFile(data: data, forPath: path)
        }
    }
}

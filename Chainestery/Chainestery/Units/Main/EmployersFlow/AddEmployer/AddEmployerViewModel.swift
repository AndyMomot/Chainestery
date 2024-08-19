//
//  AddEmployerViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 18.08.2024.
//

import Foundation
import UIKit.UIImage

extension AddEmployerView {
    final class AddEmployerViewModel: ObservableObject {
        @Published var selectedImage: UIImage = UIImage(systemName: "photo.fill") ?? .init()
        @Published var showImagePicker = false
        @Published var name: String = ""
        @Published var phone: String = ""
        @Published var salary: String = ""
        @Published var position: String = ""
        
        var isImageSelected: Bool {
            selectedImage != UIImage(systemName: "photo.fill")
        }
        
        var isValidFields: Bool {
            let isValidName = !name.isEmpty
            let isValidPhoto = !phone.isEmpty
            let isValidSalary = Double(salary) != nil && (Double(salary) ?? .zero > .zero)
            let isValidPosition = !position.isEmpty
            
            return isValidName && isValidPhoto && isValidSalary && isValidPosition
        }
        
        func setView(state: ViewState) {
            switch state {
            case .create:
                break
            case .details(let model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.selectedImage = self.getImage(for: model.id) ?? (UIImage(systemName: "photo.fill") ?? .init())
                    self.name = model.name
                    self.phone = model.phone
                    self.salary = model.salary.string()
                    self.position = model.position
                }
            }
        }
        
        func saveEmployerData(state: ViewState, completion: @escaping () -> Void) {
            guard isValidFields else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                // Employer data saving
                switch state {
                case .create:
                    let model = EmployerModel(
                        name: self.name,
                        phone: self.phone,
                        salary: Double(self.salary) ?? .zero,
                        position: self.position
                    )
                    
                    DefaultsService.addEmployer(model: model)
                    // Employer image saving
                    if let imageData = selectedImage.jpegData(compressionQuality: 1) {
                        self.saveImage(data: imageData, to: model.id)
                    }
                    
                case .details(var model):
                    model.name = self.name
                    model.phone = self.phone
                    model.salary = Double(self.salary) ?? .zero
                    model.position = self.position
                    
                    DefaultsService.editEmployer(model: model)
                    // Employer image saving
                    if let imageData = selectedImage.jpegData(compressionQuality: 1) {
                        self.saveImage(data: imageData, to: model.id)
                    }
                }
                
                completion()
            }
        }
        
        private func getImage(for imageId: String) -> UIImage? {
            let path = FileManagerService.Keys.profileImage(id: imageId).path
            guard let imageData = FileManagerService().getFile(forPath: path) else { return nil }
            return UIImage(data: imageData)
        }
        
        private func saveImage(data: Data, to pathID: String) {
            let path = FileManagerService.Keys.profileImage(id: pathID).path
            FileManagerService().saveFile(data: data, forPath: path)
        }
    }
}

extension AddEmployerView {
    enum ViewState {
        case create
        case details(model: EmployerModel)
    }
}

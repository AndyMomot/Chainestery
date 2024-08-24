//
//  RepairViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 23.08.2024.
//

import Foundation

extension RepairView {
    final class RepairViewModel: ObservableObject {
        @Published var order: OrderModel = .init(name: "", budget: 0, info: "")
        @Published var showEmployers = false
        @Published var employers: [EmployerModel] = []
        @Published var selectedEmployer: EmployerModel?
        @Published var progress: CGFloat = .zero
        @Published var showDeleteAlert = false
        
        func setOrder(order: OrderModel) {
            self.order = order
            if order.progress < .zero {
                progress = .zero
            } else if order.progress > 1 {
                progress = 1
            } else {
                self.progress = order.progress
            }
        }
        
        func getEmployers() {
            DispatchQueue.main.async { [weak self] in
                self?.employers = DefaultsService.employers
            }
        }
        
        func onGetStarted() {
            DispatchQueue.main.async { [weak self] in
                guard let self, let employer = self.selectedEmployer else {
                    return
                }
                self.order.employer = employer
                self.order.status = .inProgress
                self.order.workStartedDate = .init()
                DefaultsService.editOrder(model: self.order)
            }
        }
        
        func finishOrder(completion: @escaping () -> Void) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.order.status = .finished
                DefaultsService.editOrder(model: self.order)
                completion()
            }
        }
        
        func deleteOrder(completion: @escaping () -> Void) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                DefaultsService.removeOrder(model: self.order)
                completion()
            }
        }
    }
}

//
//  EmployersViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import Foundation

extension EmployersView {
    final class EmployersViewModel: ObservableObject {
        @Published var showAddEmployer = false
        @Published var employers: [EmployerModel] = []
        @Published var employerToShow: EmployerModel?
        @Published var showEmployer = false
        
        func getEmployers() {
            DispatchQueue.main.async { [weak self] in
                self?.employers = DefaultsService.employers
            }
        }
    }
}

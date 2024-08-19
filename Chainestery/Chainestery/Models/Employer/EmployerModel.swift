//
//  EmployerModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 18.08.2024.
//

import Foundation

struct EmployerModel: Identifiable, Codable, Hashable {
    private(set) var id = UUID().uuidString
    private(set) var date = Date()
    
    var name: String
    var phone: String
    var salary: Double
    var position: String
}

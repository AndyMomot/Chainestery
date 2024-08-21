//
//  OrderModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import Foundation

struct OrderModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    private(set) var dateCreated = Date()
    
    var name: String
    var budget: Double
    var info: String
    var workStartedDate: Date?
    var isFinish: Bool = false
}

//
//  OrderModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import Foundation

struct OrderModel: Identifiable, Codable, Hashable {
    private(set) var id = UUID().uuidString
    private(set) var dateCreated = Date()
    
    var name: String
    var budget: Double
    var info: String
    var employer: EmployerModel?
    var workStartedDate: Date?
    var status: Status = .new
    
    var progress: CGFloat {
        guard let startDate = workStartedDate else {
            return .zero
        }
        let finishDate = startDate.addOrSubtract(component: .hour, value: 1)
        guard let minutes = Date().differenceBetweenDates(component: .minute,
                                                          from: Date(),
                                                          to: finishDate)
        else {
            return .zero
        }
        
        return CGFloat(60 - minutes) / 60
    }
}

extension OrderModel {
    enum Status: Codable {
        case new
        case inProgress
        case finished
    }
}

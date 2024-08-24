//
//  OrderModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import Foundation

struct OrderModel: Identifiable, Codable, Hashable {
    private(set) var dateCreated = Date()
    private(set) var minutesForFixing = CGFloat.random(in: 15...60)
    
    var id = UUID().uuidString // don't set new value
    
    var name: String
    var budget: Double
    var info: String
    var employer: EmployerModel?
    var workStartedDate: Date?
    var status: Status = .new
    var note: String?
    
    var progress: CGFloat {
        guard let startDate = workStartedDate else {
            return .zero
        }
        let finishDate = startDate.addOrSubtract(component: .minute,
                                                 value: Int(minutesForFixing))
        guard let secondsLeft = Date().differenceBetweenDates(component: .second,
                                                          from: Date(),
                                                          to: finishDate)
        else {
            return .zero
        }
        let secondsForFixing: CGFloat = minutesForFixing * 60
        return (secondsForFixing - CGFloat(secondsLeft)) / secondsForFixing
    }
}

extension OrderModel {
    enum Status: Codable {
        case new
        case inProgress
        case finished
    }
}

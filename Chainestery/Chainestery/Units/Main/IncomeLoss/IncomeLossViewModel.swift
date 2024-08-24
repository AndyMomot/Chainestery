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
        
        @Published var mondayIncome = ""
        @Published var mondayLoss = ""
        
        @Published var tuesdayIncome = ""
        @Published var tuesdayLoss = ""
        
        @Published var wednesdayIncome = ""
        @Published var wednesdayLoss = ""
        
        @Published var thursdayIncome = ""
        @Published var thursdayLoss = ""
        
        @Published var fridayIncome = ""
        @Published var fridayLoss = ""
        
        @Published var saturdayIncome = ""
        @Published var saturdayLoss = ""
        
        @Published var sundayIncome = ""
        @Published var sundayLoss = ""
    }
}

extension IncomeLossView {
    struct IncomeLossDataModel {
        var day: Day
        var income: Int
        var loss: Int
    }
    
    enum Day: String, Codable {
        case monday = "ПН"
        case tuesday = "ВТ"
        case wednesday = "СР"
        case thursday = "ЧТ"
        case friday = "ПТ"
        case saturday = "СБ"
        case sunday = "ВС"
        
        var id: Int {
            switch self {
            case .monday:
                return 1
            case .tuesday:
                return 2
            case .wednesday:
                return 3
            case .thursday:
                return 4
            case .friday:
                return 5
            case .saturday:
                return 6
            case .sunday:
                return 7
            }
        }
    }
}

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
        
        @Published var totalIncome: Int = .zero
        @Published var totalLose: Int = .zero
        @Published var showStatistic = false
        
        func getIncomeLossData() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.data = DefaultsService.incomeLoss
                self.setTitles()
                self.calculateTotalCostsAndLoss()
            }
        }
        
        func setTitles() {
            guard !data.isEmpty else { return }
            
            if let monday = data.first(where: { $0.day == .monday}) {
                mondayIncome = "\(monday.income)"
                mondayLoss = "\(monday.loss)"
            }
            
            
            if let tuesday = data.first(where: { $0.day == .tuesday}) {
                tuesdayIncome = "\(tuesday.income)"
                tuesdayLoss = "\(tuesday.loss)"
            }
            
            if let wednesday = data.first(where: { $0.day == .wednesday}) {
                wednesdayIncome = "\(wednesday.income)"
                wednesdayLoss = "\(wednesday.loss)"
            }
            
            if let thursday = data.first(where: { $0.day == .thursday}) {
                thursdayIncome = "\(thursday.income)"
                thursdayLoss = "\(thursday.loss)"
            }
            
            if let friday = data.first(where: { $0.day == .friday}) {
                fridayIncome = "\(friday.income)"
                fridayLoss = "\(friday.loss)"
            }
            
            if let saturday = data.first(where: { $0.day == .saturday}) {
                saturdayIncome = "\(saturday.income)"
                saturdayLoss = "\(saturday.loss)"
            }
            
            if let sunday = data.first(where: { $0.day == .sunday}) {
                sundayIncome = "\(sunday.income)"
                sundayLoss = "\(sunday.loss)"
            }
        }
        
        func calculateTotalCostsAndLoss() {
            totalIncome = data.map {$0.income}.reduce(0) { $0 + $1 }
            totalLose = data.map {$0.loss}.reduce(0) { $0 + $1 }
        }
        
        func onValueChanged(model: IncomeLossDataModel) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                var incomeLoss = self.data
                
                if let index = incomeLoss.firstIndex(where: { $0.day == model.day }) {
                    incomeLoss[index] = model
                } else {
                    incomeLoss.append(model)
                }
                
                incomeLoss.sort(by: { $0.day.id < $1.day.id })
                self.data = incomeLoss
                self.calculateTotalCostsAndLoss()
            }
        }
        
        func onSave() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                DefaultsService.incomeLoss = self.data
            }
        }
    }
}

extension IncomeLossView {
    struct IncomeLossDataModel: Codable {
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

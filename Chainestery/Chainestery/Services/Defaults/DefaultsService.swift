//
//  DefaultsService.swift

import Foundation

final class DefaultsService {
    static let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    static var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
}

extension DefaultsService {
    static var employers: [EmployerModel] {
        get {
            if let data = standard.object(forKey: Keys.employers.rawValue) as? Data {
                let items = try? JSONDecoder().decode([EmployerModel].self, from: data)
                return items ?? []
            }
            return []
        }
        set {
            let items = newValue.sorted(by: { $0.date > $1.date })
            if let data = try? JSONEncoder().encode(items) {
                standard.setValue(data, forKey: Keys.employers.rawValue)
            }
        }
    }
    
    static func addEmployer(model: EmployerModel) {
        employers.append(model)
    }
    
    static func editEmployer(model: EmployerModel) {
        if let index = employers.firstIndex(where: { $0.id == model.id}) {
            employers[index] = model
        }
    }
    
    static func removeEmployer(model: EmployerModel) {
        if let index = employers.firstIndex(where: { $0.id == model.id}) {
            let item = employers.remove(at: index)
            let path = FileManagerService.Keys.image(id: item.id).path
            FileManagerService().removeFile(forPath: path)
        }
    }
}

extension DefaultsService {
    static func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
            FileManagerService().removeAllFiles()
        }
    }
}

extension DefaultsService {
    static var orders: [OrderModel] {
        get {
            if let data = standard.object(forKey: Keys.orders.rawValue) as? Data {
                let items = try? JSONDecoder().decode([OrderModel].self, from: data)
                return items ?? []
            }
            return []
        }
        set {
            let items = newValue.sorted(by: { $0.dateCreated > $1.dateCreated })
            if let data = try? JSONEncoder().encode(items) {
                standard.setValue(data, forKey: Keys.orders.rawValue)
            }
        }
    }
    
    static func addOrder(model: OrderModel) {
        orders.append(model)
    }
    
    static func editOrder(model: OrderModel) {
        if let index = orders.firstIndex(where: { $0.id == model.id}) {
            orders[index] = model
        }
    }
    
    static func removeOrder(model: OrderModel) {
        if let index = orders.firstIndex(where: { $0.id == model.id}) {
            let item = orders.remove(at: index)
            let path = FileManagerService.Keys.image(id: item.id).path
            FileManagerService().removeFile(forPath: path)
        }
    }
}

extension DefaultsService {
    static var incomeLoss: [IncomeLossView.IncomeLossDataModel] {
        get {
            if let data = standard.object(forKey: Keys.inncomeLoss.rawValue) as? Data {
                let items = try? JSONDecoder().decode([IncomeLossView.IncomeLossDataModel].self, from: data)
                return items ?? []
            }
            return []
        }
        set {
            let items = newValue.sorted(by: { $0.day.id > $1.day.id })
            if let data = try? JSONEncoder().encode(items) {
                standard.setValue(data, forKey: Keys.inncomeLoss.rawValue)
            }
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case employers
        case orders
        case inncomeLoss
    }
}

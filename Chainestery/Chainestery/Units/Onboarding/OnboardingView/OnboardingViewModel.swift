//
//  OnboardingViewModel.swift

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var isAnimatingImageOpacity = false
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://tradifundint.info")
        
        func showPrivacyFlow(rootViewModel: RootContentView.RootContentViewModel) {
            DispatchQueue.main.async {
                rootViewModel.setFlow(.privacy)
            }
        }
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var imageName: String {
            switch self {
            case .first:
                return Asset.onboarding1.name
            case .second:
                return Asset.onboarding2.name
            case .third:
                return Asset.onboarding3.name
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "РЕМОНТ"
            case .second:
                return "ВОСТАНОВИМ ТЕХНИКУ"
            case .third:
                return "РЕМОНТИРУЕМ ВСЁ"
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Добро пожаловать в Chainestery! Управляйте вашей мастерской по ремонту гаджетов с легкостью. Отслеживайте заказы, управляйте инвентарем и пр"
            case .second:
                return "Готовы стать лучшим в своей отрасли? Chainestery поможет вам организовать рабочие процессы и повысить эффективность вашей мастерской. Простое управление заказами и клиентами - в ваших руках."
            case .third:
                return "Присоединяйтесь к Chainestery - вашему надежному партнеру в мире ремонта техники. Оптимизируйте свои операции, улучшайте обслуживание клиентов и развивайтесь с нами каждый день."
            }
        }
        
        var previews: Self {
            switch self {
            case .first, .second:
                return .first
            case .third:
                return .second
            }
        }
        
        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var count: Int {
            OnboardingItem.allCases.count
        }
    }
}

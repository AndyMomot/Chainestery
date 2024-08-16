//
//  PreloaderViewModel.swift
//  Chainestery
//
//  Created by Andrii Momot on 16.08.2024.
//

import Foundation

extension PreloaderView {
    final class PreloaderViewModel: ObservableObject {
        @Published var progressString = "0"
        @Published var progress = 0.0
        @Published var timer = Timer.publish(
            every: 0.01,
            on: .main,
            in: .common
        )
            .autoconnect()
        
        func updateProgress() {
            let percent = progress * 100
            progressString = percent.string()
            
            let newValue = progress + 0.005
            progress = min(max(newValue, 0), 1)
        }
    }
}

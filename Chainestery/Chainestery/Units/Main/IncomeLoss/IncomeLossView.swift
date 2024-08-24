//
//  IncomeLossView.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI

struct IncomeLossView: View {
    @StateObject private var viewModel = IncomeLossViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
                .opacity(0.2)
            
            Asset.repairBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
                .opacity(0.2)
            
            VStack(spacing: bounds.height * 0.05) {
                NavigationBackButtonView(
                    title: "ДОХОД/УБЫТОК",
                    color: Colors.deepTeal.swiftUIColor)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 24) {
                        ChartView(data: viewModel.data) {
                            
                        }
                        .padding(.horizontal)
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    IncomeLossView()
}

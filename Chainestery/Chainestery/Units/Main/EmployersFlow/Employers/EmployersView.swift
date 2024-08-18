//
//  EmployersView.swift
//  Chainestery
//
//  Created by Andrii Momot on 17.08.2024.
//

import SwiftUI

struct EmployersView: View {
    @StateObject private var viewModel = EmployersViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    let items = Array(1...3) // Sample data
    
    let columns = [
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing: 40)
    ]
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
            
            Asset.employersBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
                .opacity(0.15)
            
            VStack(spacing: bounds.height * 0.07) {
                NavigationBackButtonView(title: "СОТРУДНИКИ",
                                         color: .white)
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: bounds.width * 0.1) {
                        ForEach(viewModel.employers) { employer in
                            Text(employer.name)
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button {
                            viewModel.showAddEmployer.toggle()
                        } label: {
                            Asset.plus.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: bounds.width * 0.14)
                        }

                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
            }
        }
        .navigationDestination(isPresented: $viewModel.showAddEmployer) {
            AddEmployerView(viewState: .create) {
                viewModel.getEmployers()
            }
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    EmployersView()
}

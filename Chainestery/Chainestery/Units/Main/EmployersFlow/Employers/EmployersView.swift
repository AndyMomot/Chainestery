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
                    LazyVGrid(columns: columns, spacing: 40) {
                        ForEach(viewModel.employers) { employer in
                            Button {
                                viewModel.employerToShow = employer
                                viewModel.showEmployer.toggle()
                            } label: {
                                EmployerView(item: employer)
                            }
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
        .onAppear {
            viewModel.getEmployers()
        }
        .navigationDestination(isPresented: $viewModel.showAddEmployer) {
            AddEmployerView(viewState: .create) {
                viewModel.getEmployers()
            }
            .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $viewModel.showEmployer) {
            if let item = viewModel.employerToShow {
                AddEmployerView(viewState: .details(model: item)) {
                    viewModel.getEmployers()
                }
                .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    EmployersView()
}

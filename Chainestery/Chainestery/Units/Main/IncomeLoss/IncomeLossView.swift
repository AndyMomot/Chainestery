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
                            withAnimation {
                                viewModel.showStatistic.toggle()
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Spacer()
                                
                                HStack(spacing: 30) {
                                    HStack(spacing: 8) {
                                        RoundedRectangle(cornerRadius: 5)
                                            .scaledToFit()
                                            .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                                            .frame(width: 13)
                                        
                                        Text("Доход $")
                                            .foregroundStyle(.black)
                                            .font(Fonts.KulimPark.light.swiftUIFont(size: 10))
                                    }
                                    
                                    HStack(spacing: 8) {
                                        RoundedRectangle(cornerRadius: 5)
                                            .scaledToFit()
                                            .foregroundStyle(Colors.redC.swiftUIColor)
                                            .frame(width: 13)
                                        
                                        Text("Убыток $")
                                            .foregroundStyle(.black)
                                            .font(Fonts.KulimPark.light.swiftUIFont(size: 10))
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            IncomeLossTextField(
                                day: IncomeLossView.Day.monday.rawValue,
                                income: $viewModel.mondayIncome,
                                loss: $viewModel.mondayLoss) { model in
                                    viewModel.onValueChanged(model: model)
                                }
                            
                            IncomeLossTextField(
                                day: IncomeLossView.Day.tuesday.rawValue,
                                income: $viewModel.tuesdayIncome,
                                loss: $viewModel.tuesdayLoss) { model in
                                    viewModel.onValueChanged(model: model)
                                }
                            
                            IncomeLossTextField(
                                day: IncomeLossView.Day.wednesday.rawValue,
                                income: $viewModel.wednesdayIncome,
                                loss: $viewModel.wednesdayLoss) { model in
                                    viewModel.onValueChanged(model: model)
                                }
                            
                            IncomeLossTextField(
                                day: IncomeLossView.Day.thursday.rawValue,
                                income: $viewModel.thursdayIncome,
                                loss: $viewModel.thursdayLoss) { model in
                                    viewModel.onValueChanged(model: model)
                                }
                            
                            IncomeLossTextField(
                                day: IncomeLossView.Day.friday.rawValue,
                                income: $viewModel.fridayIncome,
                                loss: $viewModel.fridayLoss) { model in
                                    viewModel.onValueChanged(model: model)
                                }
                            
                            IncomeLossTextField(
                                day: IncomeLossView.Day.saturday.rawValue,
                                income: $viewModel.saturdayIncome,
                                loss: $viewModel.saturdayLoss) { model in
                                    viewModel.onValueChanged(model: model)
                                }
                            
                            IncomeLossTextField(
                                day: IncomeLossView.Day.sunday.rawValue,
                                income: $viewModel.sundayIncome,
                                loss: $viewModel.sundayLoss) { model in
                                    viewModel.onValueChanged(model: model)
                                }
                        }
                        .padding(.horizontal)
                        
                        Button {
                            viewModel.onSave()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Сохранить")
                                    .foregroundStyle(.white)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 20))
                                Spacer()
                            }
                            .padding(.vertical)
                            .background(Colors.emeraldSurge.swiftUIColor)
                            .cornerRadius(20, corners: .allCorners)
                        }
                        .padding(.horizontal, bounds.width * 0.15)
                        .padding(.top)
                    }
                }
                .scrollIndicators(.never)
            }
            
            if viewModel.showStatistic {
                StatisticView(totalIncome: viewModel.totalIncome,
                              totalLose: viewModel.totalLose) {
                    viewModel.showStatistic.toggle()
                }
            }
        }
        .hideKeyboardWhenTappedAround()
        .onAppear {
            viewModel.getIncomeLossData()
        }
    }
}

#Preview {
    IncomeLossView()
}

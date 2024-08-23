//
//  RepairView.swift
//  Chainestery
//
//  Created by Andrii Momot on 23.08.2024.
//

import SwiftUI

struct RepairView: View {
    @StateObject private var viewModel = RepairViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var item: OrderModel
    var onSaved: (() -> Void)?
    
    private let columns = [
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing: 40)
    ]
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
            
            Asset.repairBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
                .opacity(0.2)
            
            VStack(spacing: 20) {
                HStack {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            viewModel.showDeleteAlert.toggle()
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                }
                .foregroundStyle(.white)
                .font(Fonts.KulimPark.semiBold.swiftUIFont(size: 30))
                
                switch viewModel.order.status {
                case .new:
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            OrderCell(item: viewModel.order)
                            
                            Text("Выберите сотрудника который приступит выполнять заказ")
                                .foregroundStyle(.white)
                                .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                            
                            Button {
                                withAnimation {
                                    viewModel.showEmployers.toggle()
                                }
                            } label: {
                                HStack(spacing: 4) {
                                    Spacer()
                                    Asset.human.swiftUIImage
                                        .resizable()
                                        .scaledToFit()
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .rotationEffect(.degrees(viewModel.showEmployers ? -90 : 90))
                                    Spacer()
                                }
                                .foregroundStyle(.black)
                                .padding(.vertical, 15)
                                .background(.white)
                                .cornerRadius(14, corners: .allCorners)
                            }
                            .frame(height: 50)
                            
                            LazyVGrid(columns: columns, spacing: 40) {
                                ForEach(viewModel.employers) { employer in
                                    let isSelected = employer.id == viewModel.selectedEmployer?.id
                                    
                                    Button {
                                        viewModel.selectedEmployer = employer
                                    } label: {
                                        EmployerView(item: employer,
                                                     showSalary: false)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                .stroke(Colors.emeraldSurge.swiftUIColor,
                                                        lineWidth: 5)
                                                .hidden(!isSelected)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            .background(Colors.deepTeal.swiftUIColor)
                            .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                            .opacity(viewModel.showEmployers ? 1 : 0)
                            
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.onGetStarted()
                                } label: {
                                    Text("Приступить")
                                        .foregroundStyle(Colors.ceruleanBlue.swiftUIColor)
                                        .font(Fonts.KulimPark.bold.swiftUIFont(size: 20))
                                        .padding(.horizontal, 40)
                                        .padding(.vertical, 14)
                                        .background(.white)
                                        .cornerRadius(30, corners: .allCorners)
                                }
                                Spacer()
                            }
                            .opacity(viewModel.showEmployers ? 1 : 0)
                            .hidden(viewModel.selectedEmployer == nil)
                        }
                    }
                    .scrollIndicators(.never)
                    
                case .inProgress, .finished:
                    let isFinished = viewModel.progress >= 1
                    
                    ScrollView {
                        VStack(alignment: .center, spacing: 20) {
                            OrderCell(item: viewModel.order)
                            
                            HStack {
                                Text(isFinished ? "Ремонт готов" : "Выполняет работу")
                                    .foregroundStyle(.white)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            
                            if let employer = viewModel.order.employer {
                                EmployerView(item: employer,
                                             showSalary: false)
                                .frame(maxWidth: 155)
                            }
                            
                            CustomProgressView(progress: viewModel.progress)
                                .frame(height: 7)
                                .padding(.horizontal, 30)
                            
                            HStack {
                                Spacer()
                                Button {
                                    if !isFinished {
                                        viewModel.finishOrder {
                                            onSaved?()
                                            dismiss.callAsFunction()
                                        }
                                    }
                                } label: {
                                    Text(isFinished ? "Готово" : "Завершить")
                                        .foregroundStyle(Colors.ceruleanBlue.swiftUIColor)
                                        .font(Fonts.KulimPark.bold.swiftUIFont(size: 20))
                                        .padding(.horizontal, 40)
                                        .padding(.vertical, 14)
                                        .background(.white)
                                        .cornerRadius(30, corners: .allCorners)
                                }
                                .opacity(isFinished ? 1 : 0.6)
                                .disabled(!isFinished)
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            if viewModel.showDeleteAlert {
                Color.white.opacity(0.6)
                    .ignoresSafeArea()
                
                CustomAlertView(title: "Вы хотите удалить ?") { flag in
                    viewModel.showDeleteAlert.toggle()
                    
                    if flag {
                        viewModel.deleteOrder() {
                            onSaved?()
                            dismiss.callAsFunction()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.setOrder(order: item)
            viewModel.getEmployers()
        }
    }
}

#Preview {
    RepairView(item: .init(name: "Ремонт телефона",
                           budget: 200,
                           info: "Профессиональная замена крышки телефона: быстро, качественно и с гарантией. Вернем вашему устройству идеальный внешний вид!",
                           status: .new))
}

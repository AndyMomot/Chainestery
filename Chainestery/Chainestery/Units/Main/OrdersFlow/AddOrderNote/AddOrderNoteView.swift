//
//  AddOrderNoteView.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI

struct AddOrderNoteView: View {
    @StateObject private var viewModel = AddOrderNoteViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var item: OrderModel
    
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
                    title: "ЗАМЕТКИ ЗАКАЗОВ",
                    color: Colors.deepTeal.swiftUIColor)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 24) {
                            // Image & Titles
                            HStack(alignment: .top, spacing: 20) {
                                if let image = viewModel.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: bounds.width * 0.25,
                                               height: bounds.width * 0.25)
                                        .clipped()
                                        .cornerRadius(10, corners: .allCorners)
                                }
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack() {
                                        Text(item.name)
                                            .foregroundStyle(.black)
                                            .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                                            .multilineTextAlignment(.leading)
                                        Spacer(minLength: 10)
                                        Text(item.budget.string() + "$")
                                            .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                                            .font(Fonts.KulimPark.bold.swiftUIFont(size: 19))
                                    }
                                    
                                    Text("Описание: ")
                                        .foregroundColor(.black)
                                        .font(Fonts.KulimPark.semiBold.swiftUIFont(size: 10))
                                    +
                                    Text(item.info)
                                        .foregroundColor(.black)
                                        .font(Fonts.KulimPark.light.swiftUIFont(size: 10))
                                }
                            }
                            
                            // Message title
                            HStack(spacing: 8) {
                                Rectangle()
                                    .foregroundStyle(Colors.redC.swiftUIColor)
                                    .frame(width: 6)
                                
                                Text("Здесь вы можете писать свои заметки по данному заказу ")
                                    .foregroundColor(.black)
                                    .font(Fonts.KulimPark.light.swiftUIFont(size: 13))
                                    .padding(.vertical, 8)
                                Spacer()
                            }
                            .background(Colors.silverGray.swiftUIColor)
                            
                            Rectangle()
                                .foregroundStyle(Colors.silverGray.swiftUIColor)
                                .frame(height: 2)
                            
                            DynamicHeightTextField(placeholder: "Напишите заметки для себя",
                                                   text: $viewModel.text)
                            .frame(minHeight: bounds.height * 0.3)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(14, corners: .allCorners)
                        
                        Button {
                            viewModel.saveNote(order: item) {
                                dismiss.callAsFunction()
                            }
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
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
            }
        }
        .onAppear {
            if let note = item.note {
                viewModel.text = note
            }
        }
    }
}

#Preview {
    AddOrderNoteView(item: .init(name: "Ремонт телефона",
                                 budget: 200,
                                 info: "Профессиональная замена крышки телефона: быстро, качественно и с гарантией. Вернем вашему устройству идеальный внешний вид!",
                                 status: .new))
}

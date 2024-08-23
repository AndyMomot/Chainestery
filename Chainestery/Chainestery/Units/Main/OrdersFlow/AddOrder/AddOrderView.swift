//
//  AddOrderView.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import SwiftUI

struct AddOrderView: View {
    var onSaved: () -> Void
    
    @StateObject private var viewModel = AddOrderViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
            
            Asset.repairBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
                .opacity(0.2)
            
            VStack(spacing: bounds.height * 0.07) {
                NavigationBackButtonView(
                    title: "СОЗДАЙТЕ ЗАКАЗ",
                    color: .white)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 26) {
                        HStack(spacing: 17) {
                            // Image button
                            Button {
                                withAnimation {
                                    viewModel.showImagePicker.toggle()
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white)
                                        .scaledToFit()
                                        .frame(width: bounds.width * 0.3)
                                    
                                    Image(uiImage: viewModel.selectedImage)
                                        .resizable()
                                        .aspectRatio(contentMode: viewModel.isImageSelected ? .fill : .fit)
                                        .padding(viewModel.isImageSelected ? .zero : 30)
                                        .frame(width: bounds.width * 0.3,
                                               height: bounds.width * 0.3)
                                        .cornerRadius(10, corners: .allCorners)
                                }
                            }
                            
                            VStack {
                                Spacer()
                                InputFieldView(
                                    title: "Напишите название заказа",
                                    text: $viewModel.name)
                            }
                        }
                        
                        InputFieldView(
                            title: "Укажите бюджет",
                            text: $viewModel.budget)
                        .keyboardType(.numberPad)
                        
                        DynamicHeightTextField(
                            placeholder: "Введите информацию",
                            text: $viewModel.info)
                            .frame(minHeight: 170)
                    }
                }
                .scrollIndicators(.never)
                .padding(.horizontal)
                
                Button {
                    viewModel.createOrder {
                        onSaved()
                        dismiss.callAsFunction()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Создать")
                            .foregroundStyle(.white)
                            .font(Fonts.KulimPark.bold.swiftUIFont(size: 20))
                        Spacer()
                    }
                    .padding(.vertical)
                    .background(Colors.emeraldSurge.swiftUIColor)
                    .cornerRadius(20, corners: .allCorners)
                }
                .padding(.horizontal, bounds.width * 0.22)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
        }
        // Publishers
        .onChange(of: viewModel.selectedImage) { value in
            let isSelected = value != UIImage(systemName: "photo.fill")
            viewModel.isImageSelected = isSelected
        }
    }
}

#Preview {
    AddOrderView() {}
}

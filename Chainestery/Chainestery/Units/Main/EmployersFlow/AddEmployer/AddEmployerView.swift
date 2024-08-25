//
//  AddEmployerView.swift
//  Chainestery
//
//  Created by Andrii Momot on 18.08.2024.
//

import SwiftUI

struct AddEmployerView: View {
    var viewState: ViewState
    
    var onSaved: (() -> Void)?
    
    @StateObject private var viewModel = AddEmployerViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepTeal.swiftUIColor
                .ignoresSafeArea()
                .opacity(0.2)
            
            Asset.employersBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
                .opacity(0.2)
            
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        
                        Button {
                            dismiss.callAsFunction()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .tint(.black)
                                .frame(width: 24, height: 24)
                        }
                        .frame(width: 34, height: 34)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 14) {
                        // Image & Info titles
                        HStack(spacing: 16) {
                            
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
                                        .clipped()
                                        .cornerRadius(10, corners: .allCorners)
                                }
                            }
                            
                            // Info labels
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.name)
                                    .foregroundStyle(Colors.silverGray.swiftUIColor)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 30))
                                
                                Text(viewModel.position)
                                    .foregroundStyle(Colors.ceruleanBlue.swiftUIColor)
                                    .font(Fonts.KulimPark.light.swiftUIFont(size: 25))
                                
                                Text(viewModel.phone)
                                    .foregroundStyle(.white)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 15))
                                
                                Text(viewModel.salary)
                                    .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 35))
                            }
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            
                            Spacer()
                        }
                        
                        InputFieldView(title: "Имя", text: $viewModel.name)
                        
                        InputFieldView(title: "Укажите должность сотрудника", text: $viewModel.position)
                        
                        InputFieldView(title: "Укажите номер телефона", text: $viewModel.phone)
                        
                        InputFieldView(title: "Укажите зарплату сотрудника", text: $viewModel.salary)
                            .keyboardType(.numberPad)
                        
                        Button {
                            viewModel.saveEmployerData(state: viewState) {
                                onSaved?()
                                dismiss.callAsFunction()
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                                .frame(height: 44)
                                .padding(.horizontal, 50)
                                .overlay {
                                    Text("Сохранить")
                                        .foregroundStyle(Colors.ceruleanBlue.swiftUIColor)
                                        .font(Fonts.KulimPark.bold.swiftUIFont(size: 16))
                                }
                                .padding(.top)
                        }
                        
                        switch viewState {
                        case .create:
                            EmptyView()
                        case .details:
                            Button {
                                withAnimation {
                                    viewModel.showDeleteAlert.toggle()
                                }
                            } label: {
                                Text("Удалить")
                                    .foregroundStyle(Colors.redC.swiftUIColor)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 16))
                            }
                        }
                    }
                    .padding()
                    .background(Colors.deepTeal.swiftUIColor)
                    .cornerRadius(24, corners: .allCorners)
                }
                
            }
            .scrollIndicators(.never)
            .padding(.horizontal, bounds.width * 0.08)
            
            if viewModel.showDeleteAlert {
                Color.white.opacity(0.6)
                    .ignoresSafeArea()
                
                CustomAlertView(title: "Вы хотите удалить ?") { flag in
                    viewModel.showDeleteAlert.toggle()
                    
                    if flag {
                        viewModel.deleteEmployer(state: self.viewState) {
                            onSaved?()
                            dismiss.callAsFunction()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .hideKeyboardWhenTappedAround()
        .onAppear {
            viewModel.setView(state: self.viewState)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
        }
    }
}

#Preview {
    AddEmployerView(viewState: .details(model: .init(
        name: "Bob",
        phone: "+380674820482",
        salary: 1000,
        position: "Developer")))
}

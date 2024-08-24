//
//  OrderCell.swift
//  Chainestery
//
//  Created by Andrii Momot on 22.08.2024.
//

import SwiftUI

struct OrderCell: View {
    var item: OrderModel
    @State var  image: Image?
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: bounds.width * 0.25,
                           height: bounds.width * 0.25)
                    .clipped()
                    .cornerRadius(10, corners: .allCorners)
                
                Spacer(minLength: 10)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(item.name)
                        .foregroundStyle(item.status == .finished ? .white : .black)
                        .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    
                    if item.status != .finished {
                        Text(item.budget.string() + "$")
                            .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                            .font(Fonts.KulimPark.bold.swiftUIFont(size: 19))
                    }
                }
                
                Text("Описание: ")
                    .foregroundColor(item.status == .finished ? .white : .black)
                    .font(Fonts.KulimPark.semiBold.swiftUIFont(size: 10))
                +
                Text(item.info)
                    .foregroundColor(.black)
                    .font(Fonts.KulimPark.light.swiftUIFont(size: 10))
            }
        }
        .padding(10)
        .background(item.status == .finished ? Colors.emeraldSurge.swiftUIColor : .white)
        .cornerRadius(14, corners: .allCorners)
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    getImage(for: item.id)
                }
            }
        }
    }
}

private extension OrderCell {
    private func getImage(for imageId: String) {
        let path = FileManagerService.Keys.image(id: imageId).path
        guard let imageData = FileManagerService().getFile(forPath: path),
              let uiImage = UIImage(data: imageData)
        else {
            return
        }
        self.image = Image(uiImage: uiImage)
    }
}

#Preview {
    ZStack {
        Color.gray
        OrderCell(item: .init(name: "Ремонт телефона",
                              budget: 200,
                              info: "Профессиональная замена крышки телефона: быстро, качественно и с гарантией. Вернем вашему устройству идеальный внешний вид!", 
                              status: .new))
        .frame(width: 380, height: 125)
    }
}

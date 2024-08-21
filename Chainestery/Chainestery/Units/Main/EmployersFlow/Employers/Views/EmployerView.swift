//
//  EmployerView.swift
//  Chainestery
//
//  Created by Andrii Momot on 19.08.2024.
//

import SwiftUI

struct EmployerView: View {
    var item: EmployerModel
    
    @State private var image: Image?
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        VStack(spacing: 12) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: bounds.width * 0.3, height: bounds.width * 0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
                    .padding(.top)
            }
            
            VStack(spacing: 0) {
                Text(item.name)
                    .foregroundStyle(.black)
                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 18))
                
                Text(item.position)
                    .foregroundStyle(Colors.ceruleanBlue.swiftUIColor)
                    .font(Fonts.KulimPark.light.swiftUIFont(size: 15))
            }
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.horizontal)
            
            HStack {
                Spacer()
                Text(item.salary.string() + "$")
                    .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 19))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
        }
        .background {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(Colors.silverGray.swiftUIColor)
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    image = getImage(for: item.id)
                }
            }
        }
    }
}

private extension EmployerView {
    private func getImage(for imageId: String) -> Image? {
        let path = FileManagerService.Keys.image(id: imageId).path
        guard let imageData = FileManagerService().getFile(forPath: path),
              let uiImage = UIImage(data: imageData)
        else { return nil }
        return Image(uiImage: uiImage)
    }
}

#Preview {
    ZStack {
        Colors.slateGray.swiftUIColor
        
        EmployerView(item: .init(
            name: "Stive",
            phone: "+380830210518",
            salary: 1000,
            position: "iOS Dev"))
        .frame(width: 155, height: 184)
    }
}

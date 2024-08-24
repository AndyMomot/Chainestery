//
//  ChartView.swift
//  Chainestery
//
//  Created by Andrii Momot on 24.08.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    var data: [IncomeLossView.IncomeLossDataModel]
    var onStatistic: () -> Void
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: 25) {
                if data.isEmpty {
                    Spacer()
                    Text("Не данных")
                        .foregroundStyle(.black)
                        .font(Fonts.KulimPark.light.swiftUIFont(size: 18))
                    Spacer()
                } else {
                    
                    Chart {
                        ForEach(data) { item in
                            BarMark(x: .value("Day", item.day),
                                    y: .value("Income", item.income),
                                    width: .fixed(24))
                            .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                            .cornerRadius(8)
                            
                            BarMark(x: .value("Day", item.day),
                                    y: .value("Loss", item.loss),
                                    width: .fixed(24))
                            .foregroundStyle(Colors.redC.swiftUIColor)
                            .cornerRadius(8)
                        }
                    }
                    .chartYAxis(.hidden)
                    
                    Button {
                        onStatistic()
                    } label: {
                        Asset.statisticBars.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23, height: 23)
                            .padding(.horizontal, 35)
                            .padding(.vertical, 12)
                            .background(Colors.slateGray.swiftUIColor)
                            .cornerRadius(10, corners: .allCorners)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            
            HStack {
                HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 5)
                        .scaledToFit()
                        .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                        .frame(width: 23)
                    
                    Text("Доход")
                        .foregroundStyle(.black)
                        .font(Fonts.KulimPark.light.swiftUIFont(size: 18))
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 5)
                        .scaledToFit()
                        .foregroundStyle(Colors.redC.swiftUIColor)
                        .frame(width: 23)
                    
                    Text("Убыток")
                        .foregroundStyle(.black)
                        .font(Fonts.KulimPark.light.swiftUIFont(size: 18))
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
            .background(.white)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
        }
        .shadow(radius: 10, y: 5)
    }
}

#Preview {
    ZStack {
        Colors.deepTeal.swiftUIColor
            .ignoresSafeArea()
            .opacity(0.2)
        
        Asset.repairBg.swiftUIImage
            .resizable()
            .ignoresSafeArea()
            .opacity(0.2)
        
//        ChartView(data: [
//            .init(id: 1, day: "ПН", income: 100, loss: 50),
//            .init(id: 1, day: "ВТ", income: 241, loss: 120),
//            .init(id: 1, day: "СР", income: 170, loss: 200),
//            .init(id: 1, day: "ЧТ", income: 155, loss: 50),
//            .init(id: 1, day: "ПТ", income: 100, loss: 90),
//            .init(id: 1, day: "СБ", income: 250, loss: 133),
//            .init(id: 1, day: "ВС", income: 300, loss: 99),
//            
//        ]) {}
//            .frame(maxHeight: 285)
//            .padding(.horizontal)
        
        ChartView(data: []) {}
            .frame(maxHeight: 285)
            .padding(.horizontal)
    }
}


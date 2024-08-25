//
//  StatisticView.swift
//  Chainestery
//
//  Created by Andrii Momot on 25.08.2024.
//

import SwiftUI

struct StatisticView: View {
    var totalIncome: Int
    var totalLose: Int
    var onClose: () -> Void
    
    var body: some View {
        ZStack {
            Colors.darkGrayCustom.swiftUIColor
                .opacity(0.8)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button {
                        onClose()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 24)
                    }
                    
                    Spacer()
                    
                    Asset.statisticBars.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 23, height: 23)
                        .padding(.horizontal, 35)
                        .padding(.vertical, 12)
                        .background(Colors.ceruleanBlue.swiftUIColor)
                        .cornerRadius(10, corners: .allCorners)
                        .shadow(radius: 10, y: 5)
                }
                
                Asset.statisticBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        HStack {
                            Spacer()
                            
                            VStack(spacing: 4) {
                                Image(systemName: "triangle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundStyle(Colors.emeraldSurge.swiftUIColor)
                                    .frame(width: 40, height: 30)
                                
                                
                                Text("\(totalIncome)")
                                    .foregroundStyle(.black)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 40))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                            
                            Spacer()
                            Rectangle()
                                .foregroundStyle(.black)
                                .frame(width: 2)
                                .padding(.vertical, 26)
                            Spacer()
                            
                            VStack(spacing: 4) {
                                Image(systemName: "triangle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundStyle(Colors.redC.swiftUIColor)
                                    .frame(width: 40, height: 30)
                                    .rotationEffect(.degrees(180))
                                
                                Text("\(totalLose)")
                                    .foregroundStyle(.black)
                                    .font(Fonts.KulimPark.bold.swiftUIFont(size: 40))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                            
                            Spacer()
                        }
                    }
                
                Text("В этом разделе фиксируется общая сумма доходов и убытков компании, занимающейся ремонтом техники. Эта информация позволяет отслеживать финансовые показатели предприятия, анализировать эффективность деятельности и принимать обоснованные решения для дальнейшего развития бизнеса.")
                    .foregroundStyle(.white)
                    .font(Fonts.KulimPark.light.swiftUIFont(size: 13))
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.5)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ZStack {
        Asset.onboarding1.swiftUIImage
            .ignoresSafeArea()
        StatisticView(totalIncome: 350,
                      totalLose: 153) {}
    }
}

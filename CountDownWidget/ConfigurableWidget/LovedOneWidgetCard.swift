//
//  LovedOneCard.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/12/04.
//


import SwiftUI
import SwiftData

struct LovedOneWidgetCard: View {
    let blueGradientColors: [Color] = [
        .blueGradientTop,
        .blueGradientBottom
    ]
    var name: String
    var birthday: Date
    var expectedLifeSpan: Int
    var exactAge: Double
    var remainingDays: Int
    
    var body: some View {
        let percentage = Double(exactAge) / Double(expectedLifeSpan) * 100
        
        VStack {
            HStack {
                Text("\(name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Text("To age \(expectedLifeSpan)")
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack(alignment: .lastTextBaseline) {
                Image(systemName: "heart.circle")
                    .font(.title)
                Text("\(remainingDays)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(remainingDays == 1 ? "day" : "days")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            ProgressBar(width: 280, height: 10, percentage: percentage, expectedLifeSpan: expectedLifeSpan)
                .padding(.bottom)
            
        }
        .foregroundStyle(.white)
        .background(Gradient(colors: blueGradientColors), in: RoundedRectangle(cornerRadius: 30))
    }
}

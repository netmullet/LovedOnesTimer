//
//  LovedOneCard.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/07/06.
//

import SwiftUI
import SwiftData

struct LovedOneCard: View {
    let blueGradientColors: [Color] = [
        .blueGradientTop,
        .blueGradientBottom
    ]
    
    var lovedOne: LovedOne
    
    var body: some View {
        let percentage = Double(lovedOne.exactAge) / Double(lovedOne.expectedLifeSpan) * 100
        
        VStack {
            HStack {
                Text("\(lovedOne.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Text("To age \(lovedOne.expectedLifeSpan)")
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack(alignment: .lastTextBaseline) {
                Image(systemName: "heart.circle")
                    .font(.title)
                Text("\(lovedOne.remainingDays)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(lovedOne.remainingDays == 1 ? "day" : "days")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            ProgressBar(width: 280, height: 10, percentage: percentage, expectedLifeSpan: lovedOne.expectedLifeSpan)
                .padding(.bottom)
            
        }
        .foregroundStyle(.white)
        .background(Gradient(colors: blueGradientColors), in: RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    LovedOneCard(lovedOne: LovedOne.sampleData[0])
}

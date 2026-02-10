//
//  DateDotsView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/01.
//

import SwiftUI


struct CountdownStatsView<T: LifeExpectancyCalculatable>: View {
    let entity: T
    
    var body: some View {
        VStack {
            Text("Age \(entity.currentAge) → \(entity.lifespan)")
                .foregroundColor(.secondary)
            let remaining = entity.remainingComponents
            Text("\(remaining.years)y \(remaining.months)m \(remaining.days)d")
                .font(.title)
                .fontWeight(.bold)
            Text("(\(entity.remainingDays.formatted()) \(entity.remainingDays == 1 ? "day" : "days"))")
                .font(.title3)
        }
    }
}

#Preview {
    CountdownStatsView(entity: LovedOne.sampleData[0])
}

//
//  LegendView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/01.
//

import SwiftUI

struct EmojiLegendView<T: LifeExpectancyCalculatable>: View {
    let entity: T
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(EmojiType.allCases, id: \.self) { type in
                HStack(spacing: 4) {
                    Text(type.emoji)
                    Text("\(type.label)")
                        .font(.caption)
                    Text("×\(entity.emojiCounts[type] ?? 0)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    EmojiLegendView(entity: LovedOne.sampleData[0])
}

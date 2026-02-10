//
//  DateDotsView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/01.
//

import SwiftUI

struct EmojiTableView<T: LifeExpectancyCalculatable>: View {
    let entity: T
    let maxColumns: Int = 10
    let maxRows: Int = 6
    
    init(entity: T, maxColumns: Int = 10, maxRows: Int = 6) {
        self.entity = entity
    }
    
    private var dots: [EmojiType] {
        entity.generateDots(maxDots: maxColumns * maxRows)
    }
    
    var body: some View {
        VStack(spacing: 6) {
            ForEach(0..<maxRows, id: \.self) { row in
                HStack(spacing: 6) {
                    ForEach(0..<maxColumns, id: \.self) { col in
                        let index = row * maxColumns + col
                        if index < dots.count {
                            Text(dots[index].emoji)
                                .font(.system(size: 20))
                                .frame(width: 24, height: 24)
                        } else {
                            Circle()
                                .fill(Color.gray.tertiary)
                                .padding(2)
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EmojiTableView(entity: LovedOne.sampleData[0])
}

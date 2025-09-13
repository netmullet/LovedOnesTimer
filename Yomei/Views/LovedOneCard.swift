//
//  LovedOneCard.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/07/06.
//

import SwiftUI
import SwiftData

struct LovedOneCard: View {
    var lovedOne: LovedOne
    
    var body: some View {
        VStack {
            HStack {
                Text("\(lovedOne.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Text("想定寿命\(lovedOne.expectedLifeSpan)歳まで")
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack(alignment: .lastTextBaseline) {
                Image(systemName: "heart.circle")
                    .font(.title)
                Text("\(lovedOne.remainingDays)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("日")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.bottom)
        }
        .foregroundStyle(.white)
        .background(.tint, in: RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}

#Preview {
    LovedOneCard(lovedOne: LovedOne.sampleData[0])
}

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
    var lifespan: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("\(name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Text("To age \(lifespan)")
                .font(.title3)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .background(Gradient(colors: blueGradientColors), in: RoundedRectangle(cornerRadius: 30))
    }
}

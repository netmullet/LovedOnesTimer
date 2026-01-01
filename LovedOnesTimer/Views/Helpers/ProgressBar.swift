//
//  ProgressBar.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/09/15.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = 280
    var height: CGFloat = 20
    var exactAge: Double = 20.0
    var expectedLifeSpan: Int = 80
    
    var body: some View {
        let percentage = Double(exactAge) / Double(expectedLifeSpan) * 100
        let multiplier = width / 100
        
        HStack {
            Text("0")
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(width: width, height: height)
                    .foregroundColor(.black.opacity(0.1))
                
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(width: percentage * multiplier, height: height)
                    .foregroundStyle(.clear)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(.red), Color(.blue)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                    )
            }
            Text("\(expectedLifeSpan)")
        }
    }
}

#Preview {
    ProgressBar()
}

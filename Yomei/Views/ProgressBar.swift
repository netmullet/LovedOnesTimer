//
//  ProgressBar.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/09/15.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = 200
    var height: CGFloat = 20
    var percentage: CGFloat = 70
    var color1 = Color(.red)
    var color2 = Color(.blue)
    
    
    var body: some View {
        let multiplier = width / 100
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: width, height: height)
                .foregroundColor(.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: percentage * multiplier, height: height)
                .foregroundStyle(.clear)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [color1, color2]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                )
        }
        
        
    }
}

#Preview {
    ProgressBar()
}

//
//  UserProfileView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/06/14.
//

import SwiftUI
import SwiftData

struct UserProfileCard: View {

    var userProfile: UserProfile
    
    var body: some View {
        let percentage = Double(userProfile.exactAge) / Double(userProfile.expectedLifeSpan) * 100
        
        VStack {
            HStack {
                Text("あなた")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Text("想定寿命\(userProfile.expectedLifeSpan)歳まで")
                .font(.title3)
                .fontWeight(.semibold)
                 
                HStack(alignment: .lastTextBaseline) {
                    Image(systemName: "heart.circle")
                        .font(.title)
                    Text("\(userProfile.remainingDays)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("日")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.bottom)
            
            ProgressBar(width: 300, height: 20, percentage: percentage, color1: .red, color2: .blue)
                .padding(.bottom)
            
            }
        .foregroundStyle(.white)
        .background(Gradient(colors: orangeGradientColors), in: RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    UserProfileCard(userProfile: UserProfile.sampleData[0])
}

//
//  UserProfileView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/06/14.
//

import SwiftUI
import SwiftData

struct UserProfileCard: View {
    let orangeGradientColors: [Color] = [
        .orangeGradientTop,
        .orangeGradientBottom
    ]

    var userProfile: UserProfile
    
    var body: some View {
        let percentage = Double(userProfile.exactAge) / Double(userProfile.expectedLifeSpan) * 100
        
        VStack {
            HStack {
                Text("You")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Text("To age \(userProfile.expectedLifeSpan)")
                .font(.title3)
                .fontWeight(.semibold)
                 
                HStack(alignment: .lastTextBaseline) {
                    Image(systemName: "heart.circle")
                        .font(.title)
                    Text("\(userProfile.remainingDays)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(userProfile.remainingDays == 1 ? "day" : "days")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.bottom)
            
            ProgressBar(width: 280, height: 20, percentage: percentage, expectedLifeSpan: userProfile.expectedLifeSpan)
                .padding(.bottom)
            }
        .foregroundStyle(.white)
        .background(Gradient(colors: orangeGradientColors), in: RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    UserProfileCard(userProfile: UserProfile.sampleData[0])
}

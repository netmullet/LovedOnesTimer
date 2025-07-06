//
//  UserProfileView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/06/14.
//

import SwiftUI
import SwiftData

struct RemainingDaysCard: View {
    @Query private var userProfiles: [UserProfile]
    
    var body: some View {
        VStack {
            HStack {
                Text("あなた")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            
            Text("平均余命")
                .font(.title3)
                .fontWeight(.semibold)
                 
            ForEach(userProfiles) { userProfile in
                if let days = userProfile.calculateRemainingDays(lifes) {
                    HStack(alignment: .lastTextBaseline) {
                        Image(systemName: "heart.circle")
                            .font(.title)
                        Text("\(days)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("日")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom)
                    
                }
            }
        }
        .foregroundStyle(.white)
        .background(.tint, in: RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}

#Preview {
    RemainingDaysCard()
        .modelContainer(SampleData.shared.modelContainer)
}
    

//
//  UserProfileView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/06/14.
//

import SwiftUI
import SwiftData

struct UserProfileView: View {
    @Query private var userProfiles: [UserProfile]
    
    var body: some View {
        VStack {
            ForEach(userProfiles) { userProfile in
                Text(userProfile.birthday.formatted())
                Text(userProfile.gender!.rawValue)
                if let days = userProfile.expectedRemainingDays(lifes) {
                    Text("あと\(days)")
                }
            }
        }
    }
}

#Preview {
    UserProfileView()
        .modelContainer(SampleData.shared.modelContainer)
}
    

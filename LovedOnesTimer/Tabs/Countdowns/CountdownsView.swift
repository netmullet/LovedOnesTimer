//
//  CountdownsView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/05.
//

import SwiftUI
import SwiftData

struct CountdownsView: View {
    @Query private var userProfiles: [UserProfile]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ForEach(userProfiles) { userProfile in
                    UserProfileCardView(userProfile: userProfile)
                }
                
                LovedOneCardListView()
            }
            .tint(Color.black)
        }
        .onAppear() {
            ATTAuthorization.requestIfNeeded()
        }
    }
}

#Preview {
    CountdownsView()
        .modelContainer(SampleData.shared.container)
}

//
//  UserProfileDotsView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/01.
//

import SwiftUI


struct UserProfileCardView: View {
    @Bindable var userProfile: UserProfile
    @State private var showUserProfileEdit = false
    
    var body: some View {
        Button {
            showUserProfileEdit = true
        } label: {
            VStack(spacing: 0) {
                CountdownStatsView(entity: userProfile)
                
                VStack(spacing: 12) {
                    EmojiTableView(entity: userProfile)
                    EmojiLegendView(entity: userProfile)
                }
                .padding()
                .cornerRadius(16)
            }
        }
        .sheet(isPresented: $showUserProfileEdit) {
            NavigationStack {
                UserProfileEditView(userProfile: userProfile)
            }
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    UserProfileCardView(userProfile: UserProfile.sampleData[0])
}

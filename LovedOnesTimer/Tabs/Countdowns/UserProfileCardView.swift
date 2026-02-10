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
                // 残り人生情報表示（共通View使用）
                CountdownStatsView(entity: userProfile)
                
                // ドットグリッド（共通View使用）
                VStack(spacing: 12) {
                    EmojiTableView(entity: userProfile)
                    
                    // 凡例（共通View使用）
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
        }
    }
}

#Preview {
    UserProfileCardView(userProfile: UserProfile.sampleData[0])
}

//
//  UserProfileDetail.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/07/21.
//

import SwiftUI

struct UserProfileDetail: View {
    @Bindable var userProfile: UserProfile
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            DatePicker("誕生日", selection: $userProfile.birthday, displayedComponents: .date)
  
            Section(header: Text("想定寿命")) {
                Stepper("\(userProfile.expectedLifeSpan)歳", value: $userProfile.expectedLifeSpan, in: 0...130)
            }
        }
        .navigationTitle("編集")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        UserProfileDetail(userProfile: SampleData.shared.userProfile)
    }
}

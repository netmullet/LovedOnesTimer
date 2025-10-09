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
            DatePicker("birthdate", selection: $userProfile.birthday, displayedComponents: .date)
  
            Section(header: Text("Life expectancy")) {
                Stepper("\(userProfile.expectedLifeSpan) years old", value: $userProfile.expectedLifeSpan, in: 0...130)
            }
        }
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        UserProfileDetail(userProfile: SampleData.shared.userProfile)
    }
}

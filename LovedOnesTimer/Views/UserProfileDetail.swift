//
//  UserProfileDetail.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/07/21.
//

import SwiftUI

struct UserProfileDetail: View {
    @Bindable var userProfile: UserProfile
    @State private var isShowSafari: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        Form {
            DatePicker("Birthdate", selection: $userProfile.birthday, displayedComponents: .date)
  
            Section(header: Text("Life expectancy")) {
                Stepper("\(userProfile.expectedLifeSpan) years old", value: $userProfile.expectedLifeSpan, in: 1...130)
            }
            
            Button {
                isShowSafari.toggle()
            } label: {
                Label("Search average lifespan", systemImage: "safari")
                    .padding(.vertical, 2)
            }
            .sheet(isPresented: $isShowSafari) {
                SafariView(url: URL(string: "https://www.google.com/search?q=平均寿命")!)
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

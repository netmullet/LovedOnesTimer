//
//  UserProfileForm.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI

struct UserProfileForm: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @Environment(\.modelContext) private var context
    
    @State private var birthday: Date = {
        var components = DateComponents()
        components.year = 2000
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    @State private var gender: Gender?
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("あなたの誕生日を\n教えてください")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            DatePicker("Select a date", selection: $birthday, in:
                        Date.distantPast...Date.now, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .environment(\.locale, Locale(identifier: "ja_JP"))
            .labelsHidden()
            .padding()
            
            Text("あなたの性別を\n教えてください")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                ForEach(Gender.allCases) { g in
                    GenderButton(label: g.emoji, text: g.displayName, isSelected: gender == g) {
                        gender = g
                    }
                }
            }
            Button(action: {
                if gender == nil {
                    showAlert = true
                } else {
                    isOnboarding = false
                    
                    saveUserProfile()
                }
            }) {
                Text("はじめる")
            }
            .alert("性別を選択してください", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
    private func saveUserProfile() {
        context.insert(UserProfile(birthday: birthday, gender: gender))
    }
}

#Preview {
    UserProfileForm()
}

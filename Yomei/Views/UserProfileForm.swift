//
//  UserProfileForm.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/09/11.
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
    
    @State private var expectedLifespan = 80
    
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
            
            Text("あなたの想定寿命を\n教えてください")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            TextField("寿命を入力 (例: 70.45)", value: $expectedLifespan, format: .number)
                .textFieldStyle(.roundedBorder)
                .padding()
                .keyboardType(.decimalPad)
            
            Button(action: {
                isOnboarding = false
                
                saveUserProfile()
            }) {
                Text("はじめる")
            }
        }
    }
    
    private func saveUserProfile() {
        context.insert(UserProfile(birthday: birthday, expectedLifeSpan: expectedLifespan))
    }
}

#Preview {
    UserProfileForm()
}

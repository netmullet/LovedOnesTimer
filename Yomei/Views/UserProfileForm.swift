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
    
    @State private var isShowSafari: Bool = false
    
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

            Stepper("\(expectedLifespan)歳", value: $expectedLifespan, in: 0...130)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal, 60)
//                .border(Color.gray, width: 1)
                .padding()
            
            Button {
                isShowSafari.toggle()
            } label: {
                Text("Safariで平均寿命を検索する")
                    .padding(.vertical, 2)
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $isShowSafari) {
                SafariView(url: URL(string: "https://www.google.com/search?q=平均寿命")!)
            }
            
            Button {
                isOnboarding = false
                
                saveUserProfile()
            } label: {
                Text("はじめる")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 128)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 80)
        }
    }
    
    private func saveUserProfile() {
        context.insert(UserProfile(birthday: birthday, expectedLifeSpan: expectedLifespan))
    }
}

#Preview {
    UserProfileForm()
}

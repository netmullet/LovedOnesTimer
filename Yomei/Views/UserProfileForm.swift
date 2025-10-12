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
            Text("Enter your date of birth")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            DatePicker("Select a date", selection: $birthday, in:
                        Date.distantPast...Date.now, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .environment(\.locale, Locale(identifier: "ja_JP"))
            .labelsHidden()
            .padding()
            
            Text("Select your \nexpected lifespan")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Stepper("\(expectedLifespan) years old", value: $expectedLifespan, in: 1...130)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal, 50)
                .padding()
            
            Button {
                isShowSafari.toggle()
            } label: {
                Label("Search average lifespan", systemImage: "safari")
                    .padding(.vertical, 2)
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $isShowSafari) {
                SafariView(url: URL(string: "https://www.google.com/search?q=平均寿命")!)
            }
            
            if #available(iOS 26.0, *) {
                Button {
                    isOnboarding = false
                    
                    saveUserProfile()
                } label: {
                    Text("START")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 128)
                }
                .tint(.blueGradientBottom)
                .buttonStyle(.borderedProminent)
                .padding(.top, 80)
                
            } else {
                Button {
                    isOnboarding = false
                    
                    saveUserProfile()
                } label: {
                    Text("はじめる")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 128)
                }
                .tint(.blueGradientBottom)
                .buttonStyle(.borderedProminent)
                .padding(.top, 80)
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

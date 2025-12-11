//
//  UserProfileForm.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/09/11.
//

import SwiftUI
import WidgetKit

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
                .font(.title2)
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)
            
            DatePicker("", selection: $birthday, in:
                        Date.distantPast...Date.now, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
            
            Text("Select your expected lifespan")
                .font(.title2)
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)

            Stepper("\(expectedLifespan) years old", value: $expectedLifespan, in: 1...130)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, 50)
                .padding()
            
            Button {
                isShowSafari.toggle()
            } label: {
                Label("Search life expectancy", systemImage: "safari")
                    .padding(.vertical, 2)
            }
            .padding(.bottom)
            .buttonStyle(.bordered)
            .sheet(isPresented: $isShowSafari) {
                SafariView(url: URL(string: "https://www.worldometers.info/demographics/life-expectancy/#countries-ranked-by-life-expectancy")!)
            }
            
            if #available(iOS 26.0, *) {
                Button {
                    isOnboarding = false
                    
                    saveUserProfile()
                } label: {
                    Text("START")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .padding()
                
            } else {
                Button {
                    isOnboarding = false
                    
                    saveUserProfile()
                } label: {
                    Text("START")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .tint(.blueGradientBottom)
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
    }
    
    private func saveUserProfile() {
        context.insert(UserProfile(birthday: birthday, expectedLifeSpan: expectedLifespan))
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview {
    UserProfileForm()
}

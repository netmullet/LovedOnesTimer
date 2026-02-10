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
    @State private var birthday = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? Date()
    @State private var lifespan = 80
    @State private var isShowSafari: Bool = false
    
    private var newUserProfile: UserProfile {
        UserProfile(birthday: birthday, lifespan: lifespan)
    }
    
    // DatePickerの日付範囲（125歳を超えないように制限）
    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let now = Date()
        let minDate = calendar.date(byAdding: .year, value: -124, to: now) ?? now
        let maxDate = now
        return minDate...maxDate
    }
    
    var body: some View {
        VStack {
            Text("Enter your date of birth")
                .font(.title2)
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)
            
            DatePicker("Date of birth", selection: $birthday, in: dateRange, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            Text("Select your expected lifespan")
                .font(.title2)
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)

            let currentAge = newUserProfile.currentAge
            let minLifespan = max(1, currentAge + 1)
            let validRange = minLifespan...125
            Stepper("\(newUserProfile.lifespan) years old", value: $lifespan, in: validRange)
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
        context.insert(UserProfile(birthday: birthday, lifespan: lifespan))
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview {
    UserProfileForm()
}

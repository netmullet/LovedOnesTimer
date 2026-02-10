//
//  UserProfileDetail.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/07/21.
//

import SwiftUI
import AdMobUI
import WidgetKit


struct UserProfileEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var userProfile: UserProfile
    
    // DatePickerの日付範囲（125歳を超えないように制限）
    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let now = Date()
        let minDate = calendar.date(byAdding: .year, value: -124, to: now) ?? now
        let maxDate = now
        return minDate...maxDate
    }

    let admobNativeUnitId: String = Bundle.main.object(forInfoDictionaryKey: "AdmobNativeUnitId") as! String
    
    var body: some View {
        Form {
            DatePicker("Date of birth", selection: $userProfile.birthday, in: dateRange, displayedComponents: .date)
  
            Section(header: Text("Life expectancy")) {
                let currentAge = userProfile.currentAge
                let minLifespan = max(1, currentAge + 1)
                let validRange = minLifespan...125
                Stepper("\(userProfile.lifespan) years old", value: $userProfile.lifespan, in: validRange)
            }
            
            Section {
                NativeAdvertisement(adUnitId: admobNativeUnitId) { loadedAd, _ in
                    HStack {
                        if let icon = loadedAd?.icon?.image {
                            Image(uiImage: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .nativeAdElement(.icon)
                        }
                        VStack {
                            if let headline = loadedAd?.headline {
                                Text(headline)
                                    .font(.headline)
                                    .nativeAdElement(.headline)
                            }
                            
                            if let body = loadedAd?.body {
                                Text(body)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .nativeAdElement(.body)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(12)
                }
            }
        }
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", systemImage: "checkmark") {
                    WidgetCenter.shared.reloadAllTimelines()
                    dismiss()
                }
                .tint(.accent)
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserProfileEditView(userProfile: SampleData.shared.userProfile)
    }
}

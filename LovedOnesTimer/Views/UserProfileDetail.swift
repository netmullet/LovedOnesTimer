//
//  UserProfileDetail.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/07/21.
//

import SwiftUI
import AdMobUI
import WidgetKit


struct UserProfileDetail: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) var displayScale
    
    @Bindable var userProfile: UserProfile
    @State private var isShowSafari: Bool = false
    @State private var draftBirthday: Date = .now
    @State private var draftExpectedLifeSpan: Int = 80

    let admobNativeUnitId: String = Bundle.main.object(forInfoDictionaryKey: "AdmobNativeUnitId") as! String
    
    var body: some View {
        Form {
            DatePicker("Birthdate", selection: $draftBirthday, displayedComponents: .date)
  
            Section(header: Text("Life expectancy")) {
                let minAge = calculateAge(from: draftBirthday) + 1
                Stepper("\(draftExpectedLifeSpan) years old", value: $draftExpectedLifeSpan, in: minAge...130)
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
                Button("Save") {
                    userProfile.birthday = draftBirthday
                    userProfile.expectedLifeSpan = draftExpectedLifeSpan
                    do {
                        try context.save()
                    } catch {
                        print("Save userProfile instance failed: \(error)")
                    }
                    WidgetCenter.shared.reloadAllTimelines()
                    dismiss()
                }
            }
        }
        .onAppear {
            draftBirthday = userProfile.birthday
            draftExpectedLifeSpan = userProfile.expectedLifeSpan
        }
        .onChange(of: draftBirthday) {
            let minAge = calculateAge(from: draftBirthday) + 1
            if draftExpectedLifeSpan < minAge {
                draftExpectedLifeSpan = minAge
            }
        }
    }
    
    func calculateAge(from birthday: Date, at date: Date = .now) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthday, to: date)
        return max(0, components.year ?? 0)
    }

}

#Preview {
    NavigationStack {
        UserProfileDetail(userProfile: SampleData.shared.userProfile)
    }
}

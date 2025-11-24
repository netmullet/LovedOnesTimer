//
//  UserProfileDetail.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/07/21.
//

import SwiftUI
import AdMobUI

struct UserProfileDetail: View {
    @Bindable var userProfile: UserProfile
    @State private var isShowSafari: Bool = false
    @State private var renderedImage = Image(systemName: "photo")
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.displayScale) var displayScale
    
    let admobNativeUnitId: String = Bundle.main.object(forInfoDictionaryKey: "AdmobNativeUnitId") as! String
    
    var body: some View {
        Form {
            DatePicker("Birthdate", selection: $userProfile.birthday, displayedComponents: .date)
  
            Section(header: Text("Life expectancy")) {
                let minAge = Int(userProfile.exactAge) + 1
                Stepper("\(userProfile.expectedLifeSpan) years old", value: $userProfile.expectedLifeSpan, in: minAge...130)
            }
            
            
            
            Section {
                ShareLink("Share", item: renderedImage, preview: SharePreview(Text("Shared image"), image: renderedImage))
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
        .onAppear { renderImage() }
        .onChange(of: userProfile.birthday) {
            let exactAge = Int(userProfile.exactAge)
            if userProfile.expectedLifeSpan < exactAge {
                userProfile.expectedLifeSpan = exactAge + 1
            }
            
            renderImage()
        }
        .onChange(of: userProfile.expectedLifeSpan) {
            renderImage()
        }
        .navigationTitle("Edit")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @MainActor func renderImage() {
        let card = UserProfileCard(userProfile: userProfile)
            .frame(width: 360, height: 180)

        let renderer = ImageRenderer(content: card)
        renderer.scale = displayScale

        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    NavigationStack {
        UserProfileDetail(userProfile: SampleData.shared.userProfile)
    }
}

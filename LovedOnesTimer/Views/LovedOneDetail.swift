//
//  LovedOneDetail.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/07/12.
//

import SwiftUI
import StoreKit
import AdMobUI


struct LovedOneDetail: View {
    @Bindable var lovedOne: LovedOne
    @State private var isShowSafari: Bool = false
    @State private var renderedImage = Image(systemName: "photo")
    @State private var isShowReviewPrompt: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.displayScale) var displayScale
    @Environment(\.requestReview) private var requestReview
    
    @AppStorage("addLovedOneCount") private var addLovedOneCount: Int = 0
    @AppStorage("hasShownReviewAlert") private var hasShownReviewAlert = false
    
    let isNew: Bool
    let admobNativeUnitId: String = Bundle.main.object(forInfoDictionaryKey: "AdmobNativeUnitId") as! String
    
    init(lovedOne: LovedOne, isNew: Bool = false) {
        self.lovedOne = lovedOne
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name / Birthdate")) {
                TextField("Name", text: $lovedOne.name)
                    .autocorrectionDisabled()
                
                DatePicker("Birthdate", selection: $lovedOne.birthday, displayedComponents: .date)
                
            }
            
            Section(header: Text("Life expectancy")) {
                let minAge = Int(lovedOne.exactAge) + 1
                Stepper("\(lovedOne.expectedLifeSpan) years old", value: $lovedOne.expectedLifeSpan, in: minAge...130)
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
        .navigationTitle(isNew ? "Add" : "Edit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addLovedOneCount += 1
                        let threshold = 3
                        if addLovedOneCount >= threshold && !hasShownReviewAlert { // 永続的に1度だけalertを起動
                            isShowReviewPrompt = true
                            hasShownReviewAlert = true
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(lovedOne)
                        dismiss()
                    }
                }
            }
        }
        .onAppear { renderImage() }
        .onChange(of: lovedOne.birthday) {
            let exactAge = Int(lovedOne.exactAge)
            if lovedOne.expectedLifeSpan < exactAge {
                lovedOne.expectedLifeSpan = exactAge + 1
            }
            
            renderImage()
        }
        .onChange(of: lovedOne.expectedLifeSpan) {
            renderImage()
        }
        .alert("How are we doing?", isPresented: $isShowReviewPrompt) {
            Button("Love it!") {
                requestReview()
                dismiss()
            }
            Button("Needs work") {
                dismiss()
            }
        } message: {
            Text("Your reviews help the app even better.")
        }
    }
    
    @MainActor func renderImage() {
        let card = LovedOneCard(lovedOne: lovedOne)
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
        LovedOneDetail(lovedOne: SampleData.shared.lovedOne)
    }
}

#Preview("New LovedOne") {
    NavigationStack {
        LovedOneDetail(lovedOne: SampleData.shared.lovedOne, isNew: true)
    }
}

//
//  LovedOneEntryView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/07.
//


import SwiftUI
import SwiftData
import StoreKit
import WidgetKit
import AdMobUI


struct LovedOneEntryView: View {
    @AppStorage("addLovedOneCount") private var requestReviewCounter: Int = 0
    @AppStorage("hasShownReviewAlert") private var hasShownReviewAlert = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.requestReview) private var requestReview
    
    @Query(sort: \LovedOne.sortOrder) private var lovedOnes: [LovedOne]
    
    @State private var isShowReviewPrompt: Bool = false
    @State private var name = ""
    @State private var birthday = Calendar.current.date(from: DateComponents(year: 2000, month: 1, day: 1)) ?? Date()
    @State private var lifespan = 80
        
    let admobNativeUnitId: String = Bundle.main.object(forInfoDictionaryKey: "AdmobNativeUnitId") as! String

    // DatePickerの日付範囲（125歳を超えないように制限）
    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let now = Date()
        let minDate = calendar.date(byAdding: .year, value: -124, to: now) ?? now
        let maxDate = now
        return minDate...maxDate
    }
    
    private var newLovedOne: LovedOne {
        LovedOne(name: name.isEmpty ? "Preview" : name,
                 birthday: birthday, 
                 lifespan: lifespan,
                 sortOrder: 0)
    }
    
    var body: some View {
        contentStack
            .navigationTitle("New Countdown")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarContent
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
    
    private var contentStack: some View {
        Form {
            Section(header: Text("Name / Date of birth")) {
                TextField("Name (Required)", text: $name)
                    .autocorrectionDisabled()
                
                DatePicker("Date of birth", selection: $birthday, in: dateRange, displayedComponents: .date)
            }
            
            Section(header: Text("Life expectancy")) {
                let currentAge = newLovedOne.currentAge
                let minLifespan = max(1, currentAge + 1)
                let validRange = minLifespan...125
                Stepper("\(lifespan) years old", value: $lifespan, in: validRange)
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
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add", systemImage: "checkmark") {
                    addLovedOne()
                }
                .tint(.accent)
                .disabled(name.isEmpty)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", systemImage: "xmark") {
                    dismiss()
                }
            }
        }
    }
    
    private func addLovedOne() {
        let maxOrder = lovedOnes.map(\.sortOrder).max() ?? -1
        let nextOrder = maxOrder + 1
        
        let newLovedOne = LovedOne(
            name: name,
            birthday: birthday,
            lifespan: lifespan,
            sortOrder: nextOrder
        )
        context.insert(newLovedOne)
        
        WidgetCenter.shared.reloadAllTimelines()
        
        // レビューリクエスト処理
        requestReviewCounter += 1
        let threshold = 3
        if requestReviewCounter >= threshold && !hasShownReviewAlert {
            isShowReviewPrompt = true
            hasShownReviewAlert = true
        } else {
            dismiss()
        }
    }
    
}

#Preview {
    NavigationStack {
        LovedOneEntryView()
    }
    .modelContainer(SharedModelContainer.shared.container)
}

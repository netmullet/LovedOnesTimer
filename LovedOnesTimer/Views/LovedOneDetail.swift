//
//  LovedOneDetail.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/07/12.
//

import SwiftUI
import StoreKit
import WidgetKit
import AdMobUI


struct LovedOneDetail: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.displayScale) var displayScale
    @Environment(\.requestReview) private var requestReview
    
    @Bindable var lovedOne: LovedOne
    @State private var draftBirthday: Date = .now
    @State private var draftExpectedLifeSpan: Int = 80
    @State private var isShowReviewPrompt: Bool = false
    @FocusState private var isFocused: Bool
    
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
                
                DatePicker("Birthdate", selection: $draftBirthday, displayedComponents: .date)
            }
            
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
            
            Section(header: Text("Note")) {
                TextEditor(text: $lovedOne.note)
                    .frame(height : 100)
                    .focused($isFocused)
                    .toolbar {
                        if isFocused {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Close") {
                                    self.isFocused = false
                                }
                            }
                        }
                    }
            }
        }
        .navigationTitle(isNew ? "Add" : "Edit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        lovedOne.birthday = draftBirthday
                        lovedOne.expectedLifeSpan = draftExpectedLifeSpan
                        do {
                            try context.save()
                        } catch {
                            print("Save lovedOne instance failed: \(error)")
                        }
                        WidgetCenter.shared.reloadAllTimelines()
                        
                        // Request review
                        addLovedOneCount += 1
                        let threshold = 3
                        if addLovedOneCount >= threshold && !hasShownReviewAlert {
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
            } else {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        lovedOne.birthday = draftBirthday
                        lovedOne.expectedLifeSpan = draftExpectedLifeSpan
                        do {
                            try context.save()
                        } catch {
                            print("Save lovedOne instance failed: \(error)")
                        }
                        WidgetCenter.shared.reloadAllTimelines()
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            draftBirthday = lovedOne.birthday
            draftExpectedLifeSpan = lovedOne.expectedLifeSpan
        }
        .onChange(of: draftBirthday) {
            let minAge = calculateAge(from: draftBirthday) + 1
            if draftExpectedLifeSpan < minAge {
                draftExpectedLifeSpan = minAge
            }
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
    
    func calculateAge(from birthday: Date, at date: Date = .now) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthday, to: date)
        return max(0, components.year ?? 0)
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

//
//  LovedOneEditView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/07.
//

import SwiftUI
import SwiftData
import StoreKit
import WidgetKit
import AdMobUI


struct LovedOneEditView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Bindable var lovedOne: LovedOne
    @State private var showDeleteConfirmation = false
    
    let admobNativeUnitId: String = Bundle.main.object(forInfoDictionaryKey: "AdmobNativeUnitId") as! String
    
    // DatePickerの日付範囲（125歳を超えないように制限）
    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let now = Date()
        let minDate = calendar.date(byAdding: .year, value: -124, to: now) ?? now
        let maxDate = now
        return minDate...maxDate
    }
    
    var body: some View {
        contentStack
            .navigationTitle("Edit Countdown")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarContent
            }
    }
    
    private var contentStack: some View {
        Form {
            Section(header: Text("Name / Date of birth")) {
                TextField("Name (Required)", text: $lovedOne.name)
                    .autocorrectionDisabled()
                
                DatePicker("Date of birth", selection: $lovedOne.birthday, in: dateRange, displayedComponents: .date)
            }
            
            Section(header: Text("Life expectancy")) {
                let currentAge = lovedOne.currentAge
                let minLifespan = max(1, currentAge + 1)
                let validRange = minLifespan...125
                Stepper("\(lovedOne.lifespan) years old", value: $lovedOne.lifespan, in: validRange)
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
                    dismiss()
                }
                .tint(.accent)
                .disabled(lovedOne.name.isEmpty)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    showDeleteConfirmation = true
                } label : {
                    Image(systemName: "trash")
                }
                .confirmationDialog("Delete Countdown", isPresented: $showDeleteConfirmation) {
                    Button("Delete Countdown", role: .destructive) {
                        context.delete(lovedOne)
                        dismiss()
                    }
                } message: {
                    Text("The countdown will be permanently deleted.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LovedOneEditView(lovedOne: SampleData.shared.lovedOne)
    }
}

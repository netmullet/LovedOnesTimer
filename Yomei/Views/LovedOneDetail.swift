//
//  LovedOneDetail.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/07/12.
//

import SwiftUI

struct LovedOneDetail: View {
    @Bindable var lovedOne: LovedOne
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(lovedOne: LovedOne, isNew: Bool = false) {
        self.lovedOne = lovedOne
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $lovedOne.name)
                .autocorrectionDisabled()
            
            DatePicker("Birthdate", selection: $lovedOne.birthday, displayedComponents: .date)
            
            Section(header: Text("Life expectancy")) {
                Stepper("\(lovedOne.expectedLifeSpan) years old", value: $lovedOne.expectedLifeSpan, in: 0...130)
            }
        }
        .navigationTitle(isNew ? "Add Loved one" : "Edit Loved one")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
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

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
            TextField("名前", text: $lovedOne.name)
                .autocorrectionDisabled()
            
            DatePicker("誕生日", selection: $lovedOne.birthday, displayedComponents: .date)
        }
        .navigationTitle(isNew ? "大切な人を追加" : "大切な人を編集")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
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

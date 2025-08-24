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
    
    @State private var lifeSpanText: String = ""
    
    init(lovedOne: LovedOne, isNew: Bool = false) {
        self.lovedOne = lovedOne
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            TextField("名前", text: $lovedOne.name)
                .autocorrectionDisabled()
            
            DatePicker("誕生日", selection: $lovedOne.birthday, displayedComponents: .date)
            
            // 想定寿命入力
            Section {
                HStack {
                    Text("想定寿命:")
                    Text("\(String(format: "%.2f歳", lovedOne.expectedLifeSpan))")
                        .fontWeight(.bold)
                }
                
                TextField("寿命を入力 (例: 70.45)", text: $lifeSpanText)
                    .keyboardType(.decimalPad) // 小数点付きの数字キーボード
                    .onChange(of: lifeSpanText) {
                        var filtered = lifeSpanText
                        
                        // 整数部と小数部に分ける
                        if let dotIndex = filtered.firstIndex(of: ".") {
                            let intPart = String(filtered[..<dotIndex])
                            let fracPart = String(filtered[filtered.index(after: dotIndex)...])
                            
                            // 整数部2桁まで
                            let limitedInt = String(intPart.prefix(3))
                            // 小数部2桁まで
                            let limitedFrac = String(fracPart.prefix(2))
                            
                            filtered = limitedInt + "." + limitedFrac
                        } else {
                            // 小数点なし → 整数部2桁まで
                            filtered = String(filtered.prefix(3))
                        }
                        
                        if filtered != lifeSpanText {
                            lifeSpanText = filtered
                        }
                        
                        // 入力値を Double に変換して userProfile に反映
                        if let value = Double(filtered) {
                            let rounded = (value * 100).rounded() / 100
                            lovedOne.expectedLifeSpan = rounded
                        }
                    }
                
                
            }
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

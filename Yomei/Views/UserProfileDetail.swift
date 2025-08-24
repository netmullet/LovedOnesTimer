//
//  UserProfileDetail.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/07/21.
//

import SwiftUI

struct UserProfileDetail: View {
    @Bindable var userProfile: UserProfile
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var lifeSpanText: String = ""
    
    var body: some View {
        Form {
            // 誕生日
            DatePicker("誕生日", selection: $userProfile.birthday, displayedComponents: .date)
            
            // 想定寿命入力
            Section {
                HStack {
                    Text("想定寿命:")
                    Text("\(String(format: "%.2f歳", userProfile.expectedLifeSpan))")
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
                            userProfile.expectedLifeSpan = rounded
                        }
                    }
                
                
            }
        }
        .navigationTitle("編集")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // 初期表示時に userProfile.lifeSpan をテキストに反映
            lifeSpanText = String(format: "%.2f", userProfile.expectedLifeSpan)
        }
    }
}

#Preview {
    NavigationStack {
        UserProfileDetail(userProfile: SampleData.shared.userProfile)
    }
}

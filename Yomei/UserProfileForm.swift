//
//  UserProfileForm.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI

struct UserProfileForm: View {
    // TODO: @Binding化
    @State private var birthday: Date = {
        var components = DateComponents()
        components.year = 2000
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    var body: some View {
        VStack {
            Text("あなたの誕生日を\n教えてください")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            Text("一度登録すると誕生日の変更はできません")
                .font(.footnote)
            
            DatePicker("Select a date", selection: $birthday, in:
                        Date.distantPast...Date.now, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .environment(\.locale, Locale(identifier: "ja_JP"))
            .labelsHidden()
            .padding()
            
            Text("あなたの性別を\n教えてください")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            
            
        }
    }
}

#Preview {
    UserProfileForm()
}

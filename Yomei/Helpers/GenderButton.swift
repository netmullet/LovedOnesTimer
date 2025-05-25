//
//  GenderButton.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/24.
//

import SwiftUI

struct GenderButton: View {
    var label: String
    var text: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(label)
                    .font(.largeTitle)
                Text(text)
                    .font(.title3)
                    .fontWeight(.bold)

            }
            .frame(width: 100, height: 100)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(isSelected ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    GenderButton(label: Gender.male.emoji, text: Gender.male.rawValue, isSelected: true) {
    }
}

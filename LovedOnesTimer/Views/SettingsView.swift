//
//  SettingsView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/09/17.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        NavigationView {
            Form {
                Button("Google") {
                    openURL(URL(string: "https://google.com")!)
                }
                
                ShareLink(
                    item: Image(.appIcon),
                    message: Text("https://google.com"),
                    preview: SharePreview("")
                ) {
                    Text("Share")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

//
//  SettingsView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/09/17.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    @State private var isShowFeedback: Bool = false
    
    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let iosVersion = UIDevice.current.systemVersion
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Image(systemName: "star.fill")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.yellow)
                    Button("Rate This App") {
                        openURL(URL(string: "https://apps.apple.com/jp/app/id6755080194?action=write-review")!)
                    }
                }
                
                HStack{
                    Image(systemName: "envelope")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.blue)
                    Button("Feedback") {
                        isShowFeedback.toggle()
                    }
                    .sheet(isPresented: $isShowFeedback) {
                        SafariView(url: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScwiOXyilscOkGvV6tP6xytjW0hvxvnqmJc7x27CV8Z9Trdag/viewform?usp=pp_url&entry.1884854462=\(appVersion)&entry.84509605=\(iosVersion)")!)
                    }
                }
                
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 20, height: 20)
                    ShareLink(item: URL(string: "https://apps.apple.com/app/id6755080194")!) {
                        Text("Share This App")
                    }
                }
                
                Section ("Version") {
                    Text(appVersion)
                }
            }
            .tint(Color.black)
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

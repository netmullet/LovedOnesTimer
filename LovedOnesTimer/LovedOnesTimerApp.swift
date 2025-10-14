//
//  YomeiApp.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI
import SwiftData

@main
struct LovedOnesTimerApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnBoardingView()
            } else {
                ContentView()
            }
        }
        .modelContainer(for: [UserProfile.self, LovedOne.self])
    }
}

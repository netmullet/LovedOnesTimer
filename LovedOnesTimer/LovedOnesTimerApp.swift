//
//  LovedOnesTimerApp.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

@main
struct LovedOnesTimerApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    init() {
        MobileAds.shared.start { status in }
    }
    
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

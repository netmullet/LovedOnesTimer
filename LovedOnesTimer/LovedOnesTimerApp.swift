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
//    @Environment(\.scenePhase) private var scenePhase: ScenePhase
    
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
//        .onChange(of: scenePhase) { _, newPhase in
//            if newPhase == .active {
//                ATTAuthorization.requestIfNeeded()
//            }
//        }
        .modelContainer(for: [UserProfile.self, LovedOne.self])
    }
}

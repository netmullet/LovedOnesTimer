//
//  OnBoardingView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/05/31.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            WelcomePage()
            UserProfileForm()
        }
        .background(.appBackground)
        .tabViewStyle(.page)
    }
}

#Preview {
    OnboardingView()
}

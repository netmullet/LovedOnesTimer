//
//  OnBoardingView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/31.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        TabView {
            WelcomePage()
            UserProfileForm()
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    OnBoardingView()
}

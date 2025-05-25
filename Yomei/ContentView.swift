//
//  ContentView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isProfileCompleted") private var isProfileCompleted = false
    
    var body: some View {
        if isProfileCompleted {
            Text("Home")
        } else {
            TabView {
                WelcomePage()
                UserProfileForm {
                    isProfileCompleted = true
                }
            }
            .tabViewStyle(.page)
        }
    }
}

#Preview {
    ContentView()
}

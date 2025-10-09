//
//  ContentView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI
import SwiftData

let blueGradientColors: [Color] = [
    .blueGradientTop,
    .blueGradientBottom
]

let orangeGradientColors: [Color] = [
    .orangeGradientTop,
    .orangeGradientBottom
]

struct ContentView: View {
    
    @State private var isShowingSetttings: Bool = false
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @Query private var userProfiles: [UserProfile]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Yomei")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingSetttings.toggle()
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .foregroundStyle(.black)
                    }
                    .sheet(isPresented: $isShowingSetttings) {
                        SettingsView()
                    }
                }
                .padding(.horizontal)
                .background(.appBackground)
                
                ForEach(userProfiles) { userProfile in
                    NavigationLink {
                        UserProfileDetail(userProfile: userProfile)
                    } label: {
                        UserProfileCard(userProfile: userProfile)
                    }
                }
                .padding()
                
                LovedOneList()
                
//                Button(action: {
//                    isOnboarding = true
//                }) {
//                    Text("Re-Start")
//                }
            }
            .background(.appBackground)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}

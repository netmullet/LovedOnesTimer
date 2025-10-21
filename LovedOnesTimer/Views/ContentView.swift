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
    @State private var availableWidth: CGFloat = 320
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @Query private var userProfiles: [UserProfile]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack {
                VStack {
                    HStack {
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
            // Host the banner in a GeometryReader so we can pass the current width to compute an adaptive size.
            GeometryReader { geo in
                BannerAdView(width: geo.size.width)
                    .frame(maxWidth: .infinity) // Reserve typical banner height; adaptive banners may adjust internally
                    .background(.ultraThinMaterial) // Slight material background to separate ad from content visually
//                    .padding(.bottom, geo.safeAreaInsets.bottom)

                    .ignoresSafeArea(edges: .bottom) // Allow the banner to extend to the bottom edge safely
                    .onAppear { availableWidth = geo.size.width } // Initialize width on first layout
                    .onChange(of: geo.size.width) { availableWidth = geo.size.width } // Update width as the device rotates or layout changes
            }
            .frame(height: 50, alignment: .bottom) // Constrain the GeometryReader's height so it doesn't take over the layout
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}

//
//  ContentView.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var isShowingSetttings: Bool = false
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @Query private var userProfiles: [UserProfile]
    
    var body: some View {
        HStack {
            Text("Yomei")
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                isShowingSetttings.toggle()
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
            }
            .sheet(isPresented: $isShowingSetttings) {
                SettingsView()
            }
        }
        .padding(.horizontal)
        
        NavigationStack {
            VStack {
                ForEach(userProfiles) { userProfile in
                    NavigationLink {
                        UserProfileDetail(userProfile: userProfile)
                    } label: {
                        UserProfileCard(userProfile: userProfile)
                    }
                }
                .foregroundStyle(.white)
                .background(.tint, in: RoundedRectangle(cornerRadius: 10))
                .padding()
                
                LovedOneList()
                
                Button(action: {
                    isOnboarding = true
                }) {
                    Text("Re-Start")
                }
            }
            .toolbar {
                
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}

//
//  ContentView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query private var userProfiles: [UserProfile]
    @State private var isShowingSetttings: Bool = false
    
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
                    .padding([.horizontal, .bottom])
                    
                    LovedOneList()
                }
                .background(.appBackground)
            }
        }
        .onAppear() {
            ATTAuthorization.requestIfNeeded()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.container)
}

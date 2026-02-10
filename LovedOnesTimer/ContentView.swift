//
//  ContentView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI
import SwiftData
import WidgetKit


struct ContentView: View {
    @AppStorage("selectedTab") private var selectedTab = 0
    @State private var showLovedOneEntry = false

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Countdowns", systemImage: "clock.circle", value: 0) {
                CountdownsView()
            }
            Tab("Settings", systemImage: "gearshape", value: 1) {
                SettingsView()
            }
            if selectedTab == 0 {
                Tab("AddCountdown", systemImage: "plus", value: 2, role: .search) {
                    Color.clear
                }
            }
        }
        .tint(.accent)
        .onChange(of: selectedTab) { oldValue, newValue in
            // 追加ボタンを押してもTabは切り替えないようにする
            if newValue == 2 && selectedTab != 0 {
                showLovedOneEntry = true
                selectedTab = oldValue
            }
        }
        .sheet(isPresented: $showLovedOneEntry) {
            NavigationStack {
                LovedOneEntryView()
            }
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.container)
}

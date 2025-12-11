//
//  StaticWidget.swift
//  StaticWidget
//
//  Created by Ryo Otsuka on 2025/12/03.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> UserProfileEntry {
        UserProfileEntry(date: Date(), userProfiles: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (UserProfileEntry) -> ()) {
        let currentDate = Date.now
        Task {
            let allUserProfiles = try await fetchUserProfiles()
            let entry = UserProfileEntry(date: currentDate, userProfiles: allUserProfiles)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        Task {
            let allUserProfiles = try await fetchUserProfiles()
            let entry = UserProfileEntry(date: currentDate, userProfiles: allUserProfiles)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func fetchUserProfiles() async throws -> [UserProfile] {
        let container = SharedModelContainer.shared.container
        let context = ModelContext(container)
        let userProfiles = try? context.fetch(FetchDescriptor<UserProfile>())
        
        return userProfiles ?? []
    }
}

struct UserProfileEntry: TimelineEntry {
    let date: Date
    let userProfiles: [UserProfile]
}

struct StaticWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if entry.userProfiles.isEmpty {
            ContentUnavailableView("No Countdown Yet.", systemImage:
                                    "plus.circle.fill")
        } else {
            UserProfileCard(userProfile: entry.userProfiles.first!)
        }
    }
}

struct StaticWidget: Widget {
    let kind: String = "StaticWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StaticWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Countdown")
        .description("This is your countdown widget.")
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
    }
}


#Preview(as: .systemSmall) {
    StaticWidget()
} timeline: {
    UserProfileEntry(date: .now, userProfiles: [])
}

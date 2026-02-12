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
        UserProfileEntry(date: Date(), userProfile: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (UserProfileEntry) -> ()) {
        let currentDate = Date.now
        Task {
            let userProfile = try await fetchUserProfile()
            let entry = UserProfileEntry(date: currentDate, userProfile: userProfile)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        Task {
            let userProfile = try await fetchUserProfile()
            let entry = UserProfileEntry(date: currentDate, userProfile: userProfile)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func fetchUserProfile() async throws -> UserProfile? {
        let container = SharedModelContainer.shared.container
        let context = ModelContext(container)
        let userProfiles = try? context.fetch(FetchDescriptor<UserProfile>())
        
        return userProfiles?.first
    }
}

struct UserProfileEntry: TimelineEntry {
    let date: Date
    let userProfile: UserProfile?
}

struct StaticWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if let userProfile = entry.userProfile {
            VStack {
                CountdownStatsView(entity: userProfile)
                
                VStack(spacing: 12) {
                    EmojiTableView(entity: userProfile)
                    EmojiLegendView(entity: userProfile)
                }
            }
        } else {
            ContentUnavailableView("No Profile Yet.", systemImage: "person.circle.fill")
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
        .configurationDisplayName("Your Countdown")
        .description("This is your countdown widget.")
        .supportedFamilies([.systemLarge])
        .contentMarginsDisabled()
    }
}


#Preview(as: .systemSmall) {
    StaticWidget()
} timeline: {
    UserProfileEntry(date: .now, userProfile: nil)
}

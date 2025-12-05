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
    var container: ModelContainer = {
        try! ModelContainer(for: UserProfile.self)
    }()
    
    func placeholder(in context: Context) -> UserProfileEntry {
        UserProfileEntry(date: Date(), userProfiles: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (UserProfileEntry) -> ()) {
        let currentDate = Date.now
        Task {
            let allUserProfiles = try await getUserProfiles()
            let entry = UserProfileEntry(date: currentDate, userProfiles: allUserProfiles)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        Task {
            let allUserProfiles = try await getUserProfiles()
            let entry = UserProfileEntry(date: currentDate, userProfiles: allUserProfiles)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    @MainActor func getUserProfiles() async throws -> [UserProfile] {
        let sort = [SortDescriptor(\UserProfile.expectedLifeSpan)]
        let descriptor = FetchDescriptor<UserProfile>(sortBy: sort)
        let allUserProfiles = try?
            container.mainContext.fetch(descriptor)
        return allUserProfiles ?? []
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

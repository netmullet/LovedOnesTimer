//
//  Provider.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/12/04.
//


import WidgetKit
import SwiftUI
import SwiftData

struct ConfigurableProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> ConfigurableEntry {
        ConfigurableEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ConfigurableEntry {
        ConfigurableEntry(date: .now, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ConfigurableEntry> {
        let entry = ConfigurableEntry(date: .now, configuration: configuration)
        
        return Timeline(entries: [entry], policy: .atEnd)
    }
}

struct ConfigurableEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct ConfigurableWidgetEntryView : View {
    var entry: ConfigurableProvider.Entry

    var body: some View {
        if entry.configuration.selectedLovedOne != nil {
            LovedOneWidgetCard(name: entry.configuration.selectedLovedOne!.id, birthday: entry.configuration.selectedLovedOne!.birthday, lifespan: entry.configuration.selectedLovedOne!.lifespan)
        }
    }
}

struct ConfigurableWidget: Widget {
    let kind: String = "ConfigurableWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: ConfigurationAppIntent.self,
                               provider: ConfigurableProvider()
        ) { entry in
            ConfigurableWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Your Loved One's Countdown")
        .description("This is your loved one's countdown widget.")
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    ConfigurableWidget()
} timeline: {
    ConfigurableEntry(date: .now, configuration: ConfigurationAppIntent())
}

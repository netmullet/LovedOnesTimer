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
        if let lovedOne = entry.configuration.selectedLovedOne {
            VStack {
                Text(lovedOne.id)
                    .font(.title2)
                    .padding(.top, 8)
                
                CountdownStatsView(entity: lovedOne)
                
                VStack(spacing: 12) {
                    EmojiTableView(entity: lovedOne)
                    EmojiLegendView(entity: lovedOne)
                }
            }
        } else {
            ContentUnavailableView("Please long-press this widget and select 'Edit Widget' to set a countdown.", systemImage: "heart.circle.fill")
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
        .supportedFamilies([.systemLarge])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    ConfigurableWidget()
} timeline: {
    ConfigurableEntry(date: .now, configuration: ConfigurationAppIntent())
}

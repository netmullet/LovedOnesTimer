//
//  ConfigurationAppIntent.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/12/04.
//


import WidgetKit
import AppIntents
import SwiftData

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is your loved one's countdown widget." }

    @Parameter(title: "Select countdown", default: nil)
    var selectedLovedOne: LovedOneEntity?
}

struct LovedOneEntity: AppEntity {
    var id: String
    var birthday: Date
    var expectedLifeSpan: Int
    var exactAge: Double
    var remainingDays: Int
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation
                = TypeDisplayRepresentation(name: "Selected Loved One")
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
    
    static var defaultQuery = LovedOneQuery()
}

struct LovedOneQuery: EntityQuery {
    func suggestedEntities() async throws -> [LovedOneEntity] {
        return try await fetchLovedOnes()
    }
    
    func defaultResult() async -> LovedOneEntity? {
        return try? await fetchLovedOnes().first
    }
    
    func entities(for identifiers: [String]) async throws -> [LovedOneEntity] {
        let lovedOnes = try await fetchLovedOnes()
        return lovedOnes.filter { identifiers.contains($0.id) }
    }
    
    private func fetchLovedOnes() async throws -> [LovedOneEntity] {
        let container = SharedModelContainer.shared.container
        let context = ModelContext(container)
        let lovedOnes = try? context.fetch(FetchDescriptor<LovedOne>())
        let results = lovedOnes?.map({ lovedOne in
            LovedOneEntity(id: lovedOne.name, birthday: lovedOne.birthday, expectedLifeSpan: lovedOne.expectedLifeSpan, exactAge: lovedOne.exactAge, remainingDays: lovedOne.remainingDays)
        })
        
        return results ?? []
    }
}

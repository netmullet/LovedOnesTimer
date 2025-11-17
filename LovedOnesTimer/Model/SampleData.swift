//
//  SampleData.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/06/14.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var userProfile: UserProfile {
        UserProfile.sampleData.first!
    }
    
    var lovedOne: LovedOne {
        LovedOne.sampleData.first!
    }
    
    private init() {
        let schema = Schema([
            UserProfile.self,
            LovedOne.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for userProfile in UserProfile.sampleData {
            context.insert(userProfile)
        }
        
        for lovedOne in LovedOne.sampleData {
            context.insert(lovedOne)
        }
    }
}

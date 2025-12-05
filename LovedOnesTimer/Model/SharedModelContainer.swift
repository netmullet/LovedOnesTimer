//
//  SharedModelContainer.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/12/04.
//

import Foundation
import SwiftData


class SharedModelContainer {
    
   static let shared = SharedModelContainer()
   
   let container: ModelContainer
   
   private init() {
       let schema = Schema([UserProfile.self, LovedOne.self])
       let modelConfiguration = ModelConfiguration(schema: schema, groupContainer: .identifier("group.com.netmullet.LovedOnesTimer"))
       
       do {
           container = try ModelContainer(for: schema, configurations: modelConfiguration)
       } catch {
           fatalError("Could not create ModelContainer: \(error)")
       }
   }
}

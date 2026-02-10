//
//  UserProfile.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/05/24.
//

import Foundation
import SwiftData

@Model
class UserProfile: LifeExpectancyCalculatable {
    var birthday: Date
    var lifespan: Int
    
    init(birthday: Date, lifespan: Int = 80) {
        self.birthday = birthday
        self.lifespan = lifespan
    }
}

extension UserProfile {
    static let sampleData = [
        UserProfile(birthday: Date.now, lifespan: 80)
    ]
}

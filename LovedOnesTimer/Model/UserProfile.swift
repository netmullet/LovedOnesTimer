//
//  UserProfile.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/05/24.
//

import Foundation
import SwiftData

@Model
class UserProfile {
    var birthday: Date = {
        let components = DateComponents(year: 2000, month: 1, day: 1)
        return Calendar.current.date(from: components) ?? .now
    }()
    var expectedLifeSpan: Int
    var note: String
    
    init(birthday: Date, expectedLifeSpan: Int = 80, note: String = "") {
        self.birthday = birthday
        self.expectedLifeSpan = expectedLifeSpan
        self.note = note
    }
    
    var exactAge: Double {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: birthday, to: Date())
        
        return Double(comps.year ?? 0)
             + Double(comps.month ?? 0) / 12.0
             + Double(comps.day ?? 0) / 365.25
    }
    
    var remainingDays: Int {
        let remainingYears = Double(expectedLifeSpan) - exactAge
        let remainingDays = Int(remainingYears * 365.25)

        return remainingDays
    }
}

extension UserProfile {
    static let sampleData = [
        UserProfile(birthday: Date.now, expectedLifeSpan: 80, note: "")
    ]
}

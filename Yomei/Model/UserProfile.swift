//
//  UserProfile.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/24.
//

import Foundation
import SwiftData

@Model
class UserProfile {
    var birthday: Date = {
        var components = DateComponents()
        components.year = 2000
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    var expectedLifeSpan: Int = 80
    
    init(birthday: Date, expectedLifeSpan: Int) {
        self.birthday = birthday
        self.expectedLifeSpan = expectedLifeSpan
    }
    
    static let sampleData = [
        UserProfile(birthday: Date.now, expectedLifeSpan: 80)
    ]
    
    var remainingDays: Int {
        let calendar = Calendar.current
        let now = Date()

        let ageComponents = calendar.dateComponents([.year, .month, .day], from: self.birthday, to: now)
        let years = ageComponents.year
        let months = ageComponents.month
        let days = ageComponents.day

        // 実年齢を算出
        let exactAge: Double = Double(years ?? 0) + Double(months ?? 0) / 12.0 + Double(days ?? 0) / 365.25

        let remainingYears = Double(expectedLifeSpan) - exactAge

        let remainingDays = Int(remainingYears * 365.25)

        return remainingDays
    }
}

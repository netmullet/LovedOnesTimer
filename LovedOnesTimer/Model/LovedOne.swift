//
//  LovedOne.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/31.
//

import Foundation
import SwiftData

@Model
class LovedOne {
    var name: String
    var birthday: Date = {
        var components = DateComponents()
        components.year = 2000
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }()
    var expectedLifeSpan: Int = 80
    var sortOrder: Int
    
    init(name: String, birthday: Date, expectedLifeSpan: Int, sortOrder: Int) {
        self.name = name
        self.birthday = birthday
        self.expectedLifeSpan = expectedLifeSpan
        self.sortOrder = sortOrder
    }
    
    static let sampleData = [
        LovedOne(name: "ひなた", birthday: Date.now, expectedLifeSpan: 80, sortOrder: 0),
        LovedOne(name: "ゆめ", birthday: Date.now, expectedLifeSpan: 88, sortOrder: 1),
        LovedOne(name: "れん", birthday: Date.now, expectedLifeSpan: 81, sortOrder: 2),
        LovedOne(name: "ゆう", birthday: Date.now,  expectedLifeSpan: 82, sortOrder: 3),
    ]
    
    var exactAge: Double {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year, .month, .day], from: self.birthday, to: now)
        let years = ageComponents.year
        let months = ageComponents.month
        let days = ageComponents.day
        
        let exactAge: Double = Double(years ?? 0) + Double(months ?? 0) / 12.0 + Double(days ?? 0) / 365.25
        
        return exactAge
    }
    
    var remainingDays: Int {
        let remainingYears = Double(expectedLifeSpan) - exactAge

        let remainingDays = Int(remainingYears * 365.25)

        return remainingDays
    }
}

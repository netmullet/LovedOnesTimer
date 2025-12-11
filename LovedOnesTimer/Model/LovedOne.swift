//
//  LovedOne.swift
//  LovedOnesTimer
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
    var note: String = ""
    var sortOrder: Int
    
    init(name: String, birthday: Date, expectedLifeSpan: Int, note: String = "", sortOrder: Int) {
        self.name = name
        self.birthday = birthday
        self.expectedLifeSpan = expectedLifeSpan
        self.note = note
        self.sortOrder = sortOrder
    }
    
    static let sampleData = [
        LovedOne(name: "あきら", birthday: Date.now, expectedLifeSpan: 75, note: "", sortOrder: 0),
        LovedOne(name: "あさこ", birthday: Date.now, expectedLifeSpan: 88, note: "", sortOrder: 1),
        LovedOne(name: "けんじ", birthday: Date.now, expectedLifeSpan: 81, note: "", sortOrder: 2),
        LovedOne(name: "ゆう", birthday: Date.now,  expectedLifeSpan: 82, note: "", sortOrder: 3),
    ]
    
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

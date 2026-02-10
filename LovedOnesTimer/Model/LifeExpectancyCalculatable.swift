//
//  LifeExpectancyCalculatable.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/01.
//

import Foundation

protocol LifeExpectancyCalculatable {
    var birthday: Date { get }
    var lifespan: Int { get }
}

// MARK: - 共通の計算プロパティ
extension LifeExpectancyCalculatable {
    var expectedDeathDate: Date {
        Calendar.current.date(byAdding: .year, value: lifespan, to: birthday) ?? birthday
    }
    
    var remainingDays: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let deathDate = calendar.startOfDay(for: expectedDeathDate)
        let components = calendar.dateComponents([.day], from: today, to: deathDate)
        return max(0, components.day ?? 0)
    }
    
    var remainingComponents: (years: Int, months: Int, days: Int) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let deathDate = calendar.startOfDay(for: expectedDeathDate)
        
        guard today < deathDate else {
            return (0, 0, 0)
        }
        
        let components = calendar.dateComponents([.year, .month, .day], from: today, to: deathDate)
        return (
            years: components.year ?? 0,
            months: components.month ?? 0,
            days: components.day ?? 0
        )
    }
    
    var currentAge: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthday, to: Date())
        return components.year ?? 0
    }
    
    func generateDots(maxDots: Int) -> [EmojiType] {
        var result: [EmojiType] = []
        let (years, months, days) = remainingComponents
        
        let tenYearCount = years / 10
        for _ in 0..<min(tenYearCount, maxDots) {
            result.append(.tenYears)
        }
        
        let oneYearCount = years % 10
        for _ in 0..<min(oneYearCount, maxDots - result.count) {
            result.append(.oneYear)
        }
        
        for _ in 0..<min(months, maxDots - result.count) {
            result.append(.oneMonth)
        }
        
        for _ in 0..<min(days, maxDots - result.count) {
            result.append(.oneDay)
        }
        
        return result
    }
    
    var emojiCounts: [EmojiType: Int] {
        let (years, months, days) = remainingComponents
        return [
            .tenYears: years / 10,
            .oneYear: years % 10,
            .oneMonth: months,
            .oneDay: days
        ]
    }
}

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
    
    var gender: Gender?
    
    init(birthday: Date, gender: Gender? = nil) {
        self.birthday = birthday
        self.gender = gender
    }
    
    static let sampleData = [
        UserProfile(birthday: Date.now, gender: .male)
    ]
    
    var expectedRemainingDays: ([Life]) -> Int? {
        return { lifeTable in
            guard let gender = self.gender else { return nil }
            
            let calendar = Calendar.current
            let now = Date()
            
            let ageComponents = calendar.dateComponents([.year, .month, .day], from: self.birthday, to: now)
            guard let years = ageComponents.year,
                  let months = ageComponents.month,
                  let days = ageComponents.day else { return nil }
            
            // 小数年齢を算出
            let exactAge = Double(years) + Double(months) / 12.0 + Double(days) / 365.25
            
            let ageInt = Int(floor(exactAge))
            
            guard let life = lifeTable.first(where: { $0.gender == gender.rawValue}) else { return nil }
            
            guard let expectancy = life.lifeExpectancies.first(where: {$0.age == ageInt}) else { return nil }
            
            let remainingYears = expectancy.lifeExpectancy - exactAge
            
            let remainingDays = Int(remainingYears * 365.25)
            
            return remainingDays
        }
    }
}

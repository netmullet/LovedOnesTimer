//
//  LovedOneTests.swift
//  LovedOneTests
//
//  Created by Ryo Otsuka on 2026/01/21.
//


import Testing
import Foundation
@testable import LovedOnesTimer

@Suite("LovedOne Model Tests")
struct LovedOneTests {
    
    // MARK: - Test Data Setup
    
    /// テスト用の固定日付を提供
    static let fixedCurrentDate = Date(timeIntervalSince1970: 1640995200) // 2022-01-01 00:00:00 UTC
    
    static func createTestLovedOne(
        name: String = "テスト太郎",
        ageYears: Int = 30,
        expectedLifeSpan: Int = 80
    ) -> LovedOne {
        let birthday = Calendar.current.date(
            byAdding: .year,
            value: -ageYears,
            to: fixedCurrentDate
        )!
        
        return LovedOne(
            name: name,
            birthday: birthday,
            expectedLifeSpan: expectedLifeSpan,
            sortOrder: 0
        )
    }
    
    // MARK: - Core Business Logic Tests
    
    @Test("正確な年齢計算 - 整数年")
    func testExactAgeCalculation_WholeYears() {
        // Given: 30歳ちょうどの人
        let thirtyYearsAgo = Calendar.current.date(
            byAdding: .year,
            value: -30,
            to: Self.fixedCurrentDate
        )!
        
        let lovedOne = LovedOne(
            name: "Test",
            birthday: thirtyYearsAgo,
            sortOrder: 0
        )
        
        // When & Then
        #expect(lovedOne.exactAge >= 29.9 && lovedOne.exactAge <= 30.1,
                "30歳ちょうどの年齢計算が不正確: \(lovedOne.exactAge)")
    }
    
    @Test("正確な年齢計算 - 端数年")
    func testExactAgeCalculation_PartialYears() {
        // Given: 30年6ヶ月前の誕生日
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Self.fixedCurrentDate)
        components.year! -= 30
        components.month! -= 6
        
        let birthday = Calendar.current.date(from: components)!
        let lovedOne = LovedOne(name: "Test", birthday: birthday, sortOrder: 0)
        
        // When & Then
        let expectedAge = 30.5
        let tolerance = 0.1
        
        #expect(abs(lovedOne.exactAge - expectedAge) < tolerance,
                "30.5歳の年齢計算が不正確: expected \(expectedAge), actual \(lovedOne.exactAge)")
    }
    
    @Test("残り日数計算 - 正常ケース")
    func testRemainingDaysCalculation_Normal() {
        // Given: 30歳で80歳まで生きる予定
        let lovedOne = Self.createTestLovedOne(ageYears: 30, expectedLifeSpan: 80)
        
        // When
        let remainingDays = lovedOne.remainingDays
        
        // Then: 約50年 = 50 * 365.25 = 18,262.5日
        let expectedDays = Int(50 * 365.25)
        let tolerance = 365 // 1年の誤差は許容
        
        #expect(abs(remainingDays - expectedDays) < tolerance,
                "残り日数計算が不正確: expected ~\(expectedDays), actual \(remainingDays)")
    }
    
    @Test("残り日数計算 - 境界値テスト")
    func testRemainingDaysCalculation_BoundaryValues() {
        // Given: 期待寿命に近い年齢
        let lovedOne = Self.createTestLovedOne(ageYears: 79, expectedLifeSpan: 80)
        
        // When
        let remainingDays = lovedOne.remainingDays
        
        // Then: 約1年分の日数
        #expect(remainingDays > 0 && remainingDays <= 366,
                "境界値での残り日数が範囲外: \(remainingDays)")
    }
    
    // MARK: - Edge Case Tests
    
    @Test("未来の誕生日でのエラーハンドリング")
    func testFutureBirthday() {
        // Given: 未来の誕生日
        let futureBirthday = Calendar.current.date(
            byAdding: .year,
            value: 1,
            to: Date()
        )!
        
        let lovedOne = LovedOne(
            name: "Future Baby",
            birthday: futureBirthday,
            sortOrder: 0
        )
        
        // When & Then: マイナス年齢にならない
        #expect(lovedOne.exactAge >= 0, "未来の誕生日で年齢がマイナスになってはいけない")
    }
    
    @Test("初期化値の検証")
    func testInitialization() {
        // Given
        let name = "テストユーザー"
        let birthday = Date()
        let expectedLifeSpan = 85
        let note = "テストメモ"
        let sortOrder = 5
        
        // When
        let lovedOne = LovedOne(
            name: name,
            birthday: birthday,
            expectedLifeSpan: expectedLifeSpan,
            note: note,
            sortOrder: sortOrder
        )
        
        // Then
        #expect(lovedOne.name == name)
        #expect(lovedOne.birthday == birthday)
        #expect(lovedOne.expectedLifeSpan == expectedLifeSpan)
        #expect(lovedOne.note == note)
        #expect(lovedOne.sortOrder == sortOrder)
    }
    
    // MARK: - Sample Data Tests
    
    @Test("サンプルデータの整合性")
    func testSampleDataIntegrity() {
        // Given
        let sampleData = LovedOne.sampleData
        
        // When & Then
        #expect(sampleData.count > 0, "サンプルデータが空ではいけない")
        
        for (index, lovedOne) in sampleData.enumerated() {
            #expect(!lovedOne.name.isEmpty, "サンプルデータ[\(index)]の名前が空")
            #expect(lovedOne.expectedLifeSpan > 0, "サンプルデータ[\(index)]の期待寿命が不正")
            #expect(lovedOne.sortOrder >= 0, "サンプルデータ[\(index)]のソート順が不正")
        }
    }
}

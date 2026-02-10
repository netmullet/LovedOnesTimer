//
//  LovedOne.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/05/31.
//

import Foundation
import SwiftData

@Model
class LovedOne: LifeExpectancyCalculatable {
    var name: String
    var birthday: Date
    var lifespan: Int
    var sortOrder: Int
    
    init(name: String, birthday: Date, lifespan: Int = 80, sortOrder: Int = 0) {
        self.name = name
        self.birthday = birthday
        self.lifespan = lifespan
        self.sortOrder = sortOrder
    }
}

extension LovedOne {
    static let sampleData = [
            LovedOne(name: "あきら", birthday: Date.now, lifespan: 75, sortOrder: 0),
            LovedOne(name: "あさこ", birthday: Date.now, lifespan: 88, sortOrder: 1),
            LovedOne(name: "けんじ", birthday: Date.now, lifespan: 81, sortOrder: 2),
            LovedOne(name: "ゆう", birthday: Date.now,  lifespan: 82, sortOrder: 3),
    ]
}

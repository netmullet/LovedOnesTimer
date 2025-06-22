//
//  Life.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/31.
//

import Foundation

struct Life: Codable, Hashable {
    var gender: String
    var lifeExpectancies: [LifeExpectancy]
    
    struct LifeExpectancy: Codable, Hashable {
        var age: Int
        var lifeExpectancy: Double
    }
}

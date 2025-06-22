//
//  Gender.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/24.
//

import SwiftUI

enum Gender: String, CaseIterable, Identifiable, Equatable, Codable {
    case male
    case female
    
    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .male: return "👨"
        case .female: return "👩"
        }
    }
    
    var displayName: String {
        switch self {
        case .male: return "男性"
        case .female: return "女性"
        }
    }
}

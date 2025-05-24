//
//  Gender.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/24.
//

import SwiftUI

enum Gender: String, CaseIterable, Identifiable, Equatable {
    case male = "男性"
    case female = "女性"
    
    var id: Self { self }

    var emoji: String {
        switch self {
        case .male: return "👨"
        case .female: return "👩"
        }
    }
}

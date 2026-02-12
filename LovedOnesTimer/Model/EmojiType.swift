//
//  DotType.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/01.
//

import Foundation
import SwiftUI

enum EmojiType: CaseIterable {
    case tenYears
    case oneYear
    case oneMonth
    case oneDay
    
    var emoji: String {
        switch self {
        case .tenYears: return "🌏"
        case .oneYear:  return "🏔️"
        case .oneMonth: return "🪨"
        case .oneDay:   return "💎"
        }
    }
    
    var label: String {
        switch self {
        case .tenYears: return "10年"
        case .oneYear:  return "1年"
        case .oneMonth: return "1ヶ月"
        case .oneDay:   return "1日"
        }
    }
}

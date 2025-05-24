//
//  UserProfile.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/24.
//

import Foundation
import SwiftData

class UserProfile {
    var birthday: Date
    var gender: Gender?
    
    init(birthday: Date, gender: Gender? = nil) {
        self.birthday = birthday
        self.gender = gender
    }
    
    //TODO: static let sampleData =
}

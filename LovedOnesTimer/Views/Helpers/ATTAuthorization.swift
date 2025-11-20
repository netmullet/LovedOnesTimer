//
//  ATTAuthorization.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/11/20.
//

import Foundation
import AppTrackingTransparency
import AdSupport

enum ATTAuthorization {
    static func requestIfNeeded() {
        guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                
            }
        }
    }
}

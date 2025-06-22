//
//  WelcomePage.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/05/18.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 150, height: 150)
                .foregroundStyle(.tint)
                
            Text("Welcome to Yomei")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("Description")
        }
        
    }
}

#Preview {
    WelcomePage()
}

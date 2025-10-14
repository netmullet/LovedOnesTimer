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
            Image(decorative: "AppIcon")
                .resizable()
                .frame(width: 150, height: 150)

            Text("Welcome to \nLoved Ones Timer")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
                .multilineTextAlignment(.center)

            Text("""
            It counts down the days left for you and the people you love.
            A gentle reminder to cherish today 
            — before it becomes “I wish I had…”
            """)
            .font(.title3)
            .multilineTextAlignment(.center)
            .lineSpacing(6)
            .padding()
        }

    }
}

#Preview {
    WelcomePage()
}

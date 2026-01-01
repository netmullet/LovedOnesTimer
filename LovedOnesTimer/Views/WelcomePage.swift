//
//  WelcomePage.swift
//  LovedOnesTimer
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

            Text("Welcome to \nLovedOnesTimer")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
                .multilineTextAlignment(.center)

            Text("It counts down the days left for you and your loved ones. It’s a gentle reminder to cherish today.")
            .font(.title3)
            .multilineTextAlignment(.center)
            .lineSpacing(6)
            .padding(20)
        }
    }
}

#Preview {
    WelcomePage()
}

//
//  LovedOneDotsView.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2026/02/01.
//

import SwiftUI

struct LovedOneCardView: View {
    @Bindable var lovedOne: LovedOne
    @State private var showLovedOneDetail = false
    
    var body: some View {
        Button {
            showLovedOneDetail = true
        } label: {
            VStack(spacing: 4) {
                Text(lovedOne.name)
                    .font(.title2)
                    .padding(.top, 12)
                
                CountdownStatsView(entity: lovedOne)
                
                VStack(spacing: 12) {
                    EmojiTableView(entity: lovedOne)
                    EmojiLegendView(entity: lovedOne)
                }
                .padding()
                .cornerRadius(16)
            }
            .foregroundStyle(.black)
            .background(Color.gray.gradient.secondary, in: RoundedRectangle(cornerRadius: 30))
            
        }
        .sheet(isPresented: $showLovedOneDetail) {
            NavigationStack {
                LovedOneEditView(lovedOne: lovedOne)
            }
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    NavigationStack {
        LovedOneCardView(lovedOne: LovedOne.sampleData[0])
    }
}

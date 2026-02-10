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
                
                // 残り人生情報表示（共通View使用）
                CountdownStatsView(entity: lovedOne)
                
                // ドットグリッド（共通View使用）
                VStack(spacing: 12) {
                    EmojiTableView(entity: lovedOne)
                    
                    // 凡例（共通View使用）
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
        }
    }
}

#Preview {
    NavigationStack {
        LovedOneCardView(lovedOne: LovedOne.sampleData[0])
    }
}

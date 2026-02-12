//
//  LovedOneList.swift
//  LovedOnesTimer
//
//  Created by Ryo Otsuka on 2025/07/06.
//

import SwiftUI
import SwiftData


struct LovedOneCardListView: View {
    @Query(sort: \LovedOne.sortOrder) private var lovedOnes: [LovedOne]
    
    var body: some View {
        Group {
            if !lovedOnes.isEmpty {
                if lovedOnes.count == 1 {
                    HStack {
                        LovedOneCardView(lovedOne: lovedOnes[0])
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(lovedOnes) { lovedOne in
                                LovedOneCardView(lovedOne: lovedOne)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .padding(.horizontal, 10.0)
                    .scrollClipDisabled()
                }
            } else {
                ContentUnavailableView {
                    Label("Add Countdowns", systemImage: "person.and.person")
                } description: {
                    Text("Add a countdown from the plus button below.")
                }
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        LovedOneCardListView()
            .modelContainer(SampleData.shared.container)
    }
}

#Preview("Empty List") {
    LovedOneCardListView()
        .modelContainer(for: LovedOne.self, inMemory: true)
}

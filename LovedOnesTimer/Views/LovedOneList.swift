//
//  LovedOneList.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/07/06.
//

import SwiftUI
import SwiftData

struct LovedOneList: View {
    @Query(sort: \LovedOne.sortOrder) private var lovedOnes: [LovedOne]
    @Environment(\.modelContext) private var context
    @State private var newLovedOne: LovedOne?
    
    var body: some View {
        HStack {
            Text("Loved Ones List")
                .font(.headline)
            Spacer()
            Button(action: addLovedOne) {
                Label("", systemImage: "plus")
            }
            EditButton()
                
        }
        .foregroundStyle(Color(.label))
        .padding(.horizontal)
        
        Group {
            if !lovedOnes.isEmpty {
                List {
                    ForEach(lovedOnes) { lovedOne in
                        LovedOneCard(lovedOne: lovedOne)
                            .background(
                                NavigationLink("", destination: LovedOneDetail(lovedOne: lovedOne))
                                    .opacity(0)
                            )
                    }
                    .onMove(perform: moveLovedOne)
                    .onDelete(perform: deleteLovedOne(indexes:))
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.appBackground)
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView {
                    Label("Add Loved ones", systemImage: "person.and.person")
                } description: {
                    Text("Add your loved one from the plus button above.")
                }
            }
        }
        .sheet(item: $newLovedOne) { lovedOne in
            NavigationStack {
                LovedOneDetail(lovedOne: lovedOne, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }
    
    private func addLovedOne() {
        let maxOrder = lovedOnes.map(\.sortOrder).max() ?? -1
        let nextOrder = maxOrder + 1
        
        let newLovedOne = LovedOne(
            name: "",
            birthday: Date(timeIntervalSinceReferenceDate: 0),
            expectedLifeSpan: 80,
            sortOrder: nextOrder
        )
        context.insert(newLovedOne)
        self.newLovedOne = newLovedOne
    }
    
    private func moveLovedOne(from source: IndexSet, to destination: Int) {
        var ordered = lovedOnes
        ordered.move(fromOffsets: source, toOffset: destination)
        
        for (index, item) in ordered.enumerated() {
            item.sortOrder = index
        }
    }
    
    private func deleteLovedOne(indexes: IndexSet) {
        for index in indexes {
            context.delete(lovedOnes[index])
        }
    }
}

#Preview {
    LovedOneList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty List") {
    LovedOneList()
        .modelContainer(for: LovedOne.self, inMemory: true)
}

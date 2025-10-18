//
//  LovedOneDetail.swift
//  Yomei
//
//  Created by Ryo Otsuka on 2025/07/12.
//

import SwiftUI

struct LovedOneDetail: View {
    @Bindable var lovedOne: LovedOne
    @State private var isShowSafari: Bool = false
    @State private var renderedImage = Image(systemName: "photo")
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.displayScale) var displayScale
    
    let isNew: Bool
    
    init(lovedOne: LovedOne, isNew: Bool = false) {
        self.lovedOne = lovedOne
        self.isNew = isNew
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name / Birthdate")) {
                TextField("Name", text: $lovedOne.name)
                    .autocorrectionDisabled()
                
                DatePicker("Birthdate", selection: $lovedOne.birthday, displayedComponents: .date)
                
            }
            Section(header: Text("Life expectancy")) {
                Stepper("\(lovedOne.expectedLifeSpan) years old", value: $lovedOne.expectedLifeSpan, in: 1...130)
            }
            
            Button {
                isShowSafari.toggle()
            } label: {
                Label("Search average lifespan", systemImage: "safari")
                    .padding(.vertical, 2)
            }
            .sheet(isPresented: $isShowSafari) {
                SafariView(url: URL(string: "https://www.google.com/search?q=平均寿命")!)
            }
            
            Section {
                ShareLink("Share the timer", item: renderedImage, preview: SharePreview(Text("Shared image"), image: renderedImage))
            }
        }
        .navigationTitle(isNew ? "Add Loved one" : "Edit Loved one")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(lovedOne)
                        dismiss()
                    }
                }
            }
        }
        .onAppear { renderImage() }
    }
    
    @MainActor func renderImage() {
        let renderer = ImageRenderer(content: LovedOneCard(lovedOne: lovedOne))
        
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            renderedImage = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    NavigationStack {
        LovedOneDetail(lovedOne: SampleData.shared.lovedOne)
    }
}

#Preview("New LovedOne") {
    NavigationStack {
        LovedOneDetail(lovedOne: SampleData.shared.lovedOne, isNew: true)
    }
}

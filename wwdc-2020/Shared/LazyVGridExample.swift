//
//  LazyVGridExample.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

struct LazyVGridExample: View {
    
    private let sfSymbols: [String] = [
        "paperplane.fill",
        "calendar.circle.fill",
        "book.circle.fill",
        "person.crop.circle.fill",
        "moon",
        "moon.fill",
        "cloud",
        "cloud.drizzle.fill",
        "cloud.rain.fill",
        "cloud.heavyrain",
        "cloud.heavyrain.fill",
        "cloud.bolt.fill"
    ]

    @State private var minimumItemSize: CGFloat = 50
    @State private var spacing: CGFloat = 8
    
    private var columns: [GridItem] {
        [
            GridItem(.adaptive(minimum: minimumItemSize), spacing: spacing)
        ]
    }
    
    var body: some View {
        ScrollView {
            WWDCLink(title: "Stacks, Grids, and Outlines in SwiftUI", url: "https://developer.apple.com/wwdc20/10031")
                .padding(.vertical, 20)
            
            SizingControlsView(minimumItemSize: $minimumItemSize, gridSpacing: $spacing)
            
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(1...10000, id: \.self) { i in
                    SFSymbolView(named: sfSymbols[i % sfSymbols.count])
                }
            }
        }
        .navigationTitle("Lazy VGrid")
        .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

private struct SizingControlsView: View {
    @Binding var minimumItemSize: CGFloat
    @Binding var gridSpacing: CGFloat
    
    var body: some View {
        Group {
            Text("Grid Spacing: \(Int(gridSpacing))")
            Slider(value: $gridSpacing, in: 0...200)
            
            Text("Minimum item size: \(Int(minimumItemSize))")
            Slider(value: $minimumItemSize, in: 25...200)
                .padding(.bottom, 20)
        }
    }
}

private struct SFSymbolView: View {
    let name: String
    
    init(named name: String) {
        self.name = name
    }
    
    var body: some View {
        Image(systemName: name)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct LazyVGridExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LazyVGridExample()
        }
    }
}

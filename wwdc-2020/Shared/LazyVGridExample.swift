//
//  LazyVGridExample.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

struct LazyVGridExample: View {
    
    let sfSymbols: [String] = [
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
            WWDCLinkView(title: "Stacks, Grids, and Outlines in SwiftUI", url: "https://developer.apple.com/wwdc20/10031")
                .padding(.vertical, 20)
            
            SizingControlsView(minimumItemSize: $minimumItemSize, spacing: $spacing)
            
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(sfSymbols, id: \.self) { symbol in
                    SFSymbolView(named: symbol)
                }
                
                ForEach(1...10000, id: \.self) { number in
                    Text("\(number)")
                        .font(.largeTitle)
                }
            }
        }
        .navigationTitle("Lazy VGrid")
        .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct SizingControlsView: View {
    @Binding var minimumItemSize: CGFloat
    @Binding var spacing: CGFloat
    
    var body: some View {
        Group {
            Text("Grid Spacing: \(Int(spacing))")
            Slider(value: $spacing, in: 0...200)
            
            Text("Minimum item size: \(Int(minimumItemSize))")
            Slider(value: $minimumItemSize, in: 25...200)
        }
    }
}

struct SFSymbolView: View {
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
        LazyVGridExample()
    }
}

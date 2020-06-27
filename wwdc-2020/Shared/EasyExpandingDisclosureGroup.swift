//
//  EasyExpandingDisclosureGroup.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/27/20.
//

import SwiftUI

/// A DisclosureGroup that expands when tapped, in addition to the system-provided
/// expanding that occurs when the user taps the disclosure indicator
struct EasyExpandingDisclosureGroup<Content, Label>: View where Content: View,
                                                                Label: View {
    @State private var isExpanded = false
    
    let content: () -> Content
    let label: () -> Label
    
    init(@ViewBuilder content: @escaping () -> Content,
                      @ViewBuilder label: @escaping () -> Label) {
        self.content = content
        self.label = label
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            content()
        }
        label: {
            label()
        }
        // Adjust the tap area of the view.
        // See: https://www.hackingwithswift.com/quick-start/swiftui/how-to-control-the-tappable-area-of-a-view-using-contentshape
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}

struct EasyExpandingDisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        List {
            EasyExpandingDisclosureGroup {
                Text("Peekaboo")
            } label: {
                Text("ViewBuilders are cool")
            }
        }
    }
}

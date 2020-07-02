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
    private var isExpanded: Binding<Bool>?
    @State private var defaultIsExpanded = false
    
    private let content: () -> Content
    private let label: () -> Label
    
    init(isExpanded: Binding<Bool>? = nil,
         @ViewBuilder content: @escaping () -> Content,
         @ViewBuilder label: @escaping () -> Label) {
        self.isExpanded = isExpanded
        self.content = content
        self.label = label
    }
    
    var body: some View {
        let isExpanded = self.isExpanded ??
            Binding(
                get: { self.defaultIsExpanded },
                set: { self.defaultIsExpanded = $0 }
            )
        
        return DisclosureGroup(isExpanded: isExpanded) {
            content()
        } label: {
            label()
                // All the below modifiers adjust the tap area of the view.
                // See: https://www.hackingwithswift.com/quick-start/swiftui/how-to-control-the-tappable-area-of-a-view-using-contentshape
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.wrappedValue.toggle()
                    }
                }
        }
    }
}

struct EasyExpandingDisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EasyExpandingDisclosureGroup {
                Text("Peekaboo")
            } label: {
                Text("ViewBuilders are cool")
            }
            
            List {
                EasyExpandingDisclosureGroup(isExpanded: .constant(true)) {
                    Text("Peekaboo")
                } label: {
                    Text("ViewBuilders are cool")
                }
            }
            .frame(height: 75)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

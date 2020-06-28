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
    private var isExpandedBinding: Binding<Bool>?
    
    /// It would be great to have a single isExpanded that tries to get the binding or uses a fallback State variable, or at
    /// least have an assertion here that fails when one tries to get the default value but `isExpandedBinding` is not nil
    @State private var defaultIsExpanded = false
    
    let content: () -> Content
    let label: () -> Label
    
    init(isExpanded: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content,
         @ViewBuilder label: @escaping () -> Label) {
        self.isExpandedBinding = isExpanded
        self.content = content
        self.label = label
    }
    
    init(@ViewBuilder content: @escaping () -> Content,
         @ViewBuilder label: @escaping () -> Label) {
        self.content = content
        self.label = label
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: isExpandedBinding ?? $defaultIsExpanded) {
            content()
        }
        label: {
            label()
                // All the below modifiers adjust the tap area of the view.
                // See: https://www.hackingwithswift.com/quick-start/swiftui/how-to-control-the-tappable-area-of-a-view-using-contentshape
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        if let binding = isExpandedBinding {
                            binding.wrappedValue.toggle()
                        } else {
                            defaultIsExpanded.toggle()
                        }
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

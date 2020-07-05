//
//  DragToDismissModifier.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 7/4/20.
//

import SwiftUI

/// Returns a view that can be dismissed by swiping right from anywhere on the screen.
/// Similar to the NavigationView's edge pan gesture, but currently isn't interactive.
struct DragToDismiss: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// SwiftUI interactive transitions are difficult at the time of writing.
    /// Ideally, I'd like this drag gesture to be interactive like NavigationView's edge pan gesture.
    /// Currently this will just animate the offset and opacity of the NavigationView's presented view, but won't
    /// animate the previous view in the navigation stack like the system transition.
    ///
    /// Once this is implemented, offset can be refactored to a binding which will animate the previous view alongside `content`
    var isInteractive: Bool = false
    
    @State private var offset: CGSize = .zero
    
    private var appliedViewOffset: CGFloat {
        guard isInteractive else {
            return 0
        }
        
        return max(0, offset.width)
    }
    
    private var opacity: Double {
        guard isInteractive else {
            return 1
        }
        
        return 2 - Double(offset.width / 75)
    }
    
    var dragToDismissGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                self.offset = gesture.translation
            }
            .onEnded { _ in
                if offset.width > 50 {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    offset = .zero
                }
            }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .contentShape(Rectangle())
        .offset(x: appliedViewOffset, y: 0)
        .opacity(opacity)
        .gesture(dragToDismissGesture)
    }
}

//
//  BadAnyProgressViewTypeErasure.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 7/3/20.
//
// An attempt at creating my own type erasure similar to `AnyView`. Not recommended
// unless we figure out a way to restore `AnyProgressviewStyle`'s wrapped view's type.
// See:https://forums.swift.org/t/why-some-swiftui-views-have-body-swift-never/27372/8

import SwiftUI
import Combine

protocol TypeErasing {
    var erasedValue: Any { get }
}

struct ProgressViewStyleTypeEraser<S: ProgressViewStyle>: TypeErasing {
    let style: S
    var erasedValue: Any {
        style
    }
}

// MARK: - Type-erased `ProgressViewStyle` attempt

/// After some research, it seems this isn't possible yet without leveraging SwiftUI's internal implementations.
/// See: https://forums.swift.org/t/why-some-swiftui-views-have-body-swift-never/27372/8
/// - Tag: AnyProgressViewStyle
struct AnyProgressViewStyle: ProgressViewStyle {
    private var eraser: TypeErasing
    
    init<S>(_ style: S) where S : ProgressViewStyle {
        eraser = ProgressViewStyleTypeEraser(style: style)
    }
    
    private var wrappedStyle: Any {
        eraser.erasedValue
    }
    
    /// In AnyView, this type is Never, telling SwiftUI to internally call its wrapped subview's `body` instead.
    typealias Body = AnyView
    
    func makeBody(configuration: Self.Configuration) -> Self.Body {
        // See the AnyProgressViewStyle documentation for why we have to do this.
        // Overall, this is not a pattern I'd recommend using moving forward.
        if let style = wrappedStyle as? DefaultProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        } else if let style = wrappedStyle as? CircularProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        } else if let style = wrappedStyle as? LinearProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        }
        
        fatalError("Need to figure out to to restore the type of ProgressViewStyle!")
    }
}

//
//  AccentColor.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/27/20.
//

import SwiftUI

/// This is required since SwiftUI doesn't currently have a good way to load a Color from a String or persist a Color with AppStorage.
enum AccentColor: String, CaseIterable {
    case blue = "blue"
    case red = "red"
    case green = "green"
    case purple = "purple"
    
    var color: Color {
        switch self {
        case .blue:
            return .blue
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }
}

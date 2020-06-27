//
//  VerticallyCenteredLabelImageAlignmentStyle.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

/// Fixes a bug in SwiftUI in Xcode 12.0 where the Label view's image is not vertically centered.
/// This just wraps the label's items in an HStack which implicitly centers them vertically.
/// See: https://stackoverflow.com/questions/62556361/swiftui-label-text-and-image-vertically-misaligned
struct VerticallyCenteredLabelImageAlignmentStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
    }
}

//
//  NewLocationPermissionsInfoView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/28/20.
//

import SwiftUI

struct PermissionsInfoPopoverView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    @Binding var isPresented: Bool
    
    private let description =
"""
Users now have much more control over location permissions, including reduced-accuracy location permissions and temporary full-accuracy permisisons.
Some CLLocationManager class methods have been deprecated.
"""
    
    var dismissButton: AnyView {
        // Ideally we should use size classes and modalPresentationStyle here to
        // detect if we're presenting a popover on iPad vs. presenting overFullscreen
        // on an iPhone.
//        guard UIDevice.current.userInterfaceIdiom == .phone else {
//            return AnyView(EmptyView())
//        }
        return AnyView(
            VStack(alignment: .trailing) {
                Button {
                    isPresented = false
                } label: {
                    Text("Done")
                }
                .foregroundColor(userSettings.accentColor)
                
                Spacer()
            }
            .padding()
        )
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            dismissButton
            
            VStack(alignment: .leading, spacing: 10) {
                Text("tl;dr")
                    .fontWeight(.bold)
                
                ForEach(description.components(separatedBy: "\n"), id: \.self) {
                    Text("• \($0)")
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                WWDCLink(title: "What's new in location", url: "https://developer.apple.com/wwdc20/10660")
                WWDCLink(title: "Core Location API changes", url: "https://developer.apple.com/documentation/corelocation?changes=latest_minor", image: "doc.text.fill")                
            }
            .padding()
        }
    }
}

struct NewLocationPermissionsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        PermissionsInfoPopoverView(isPresented: .constant(true))
//            .environment(\.horizontalSizeClass, .compact)
//            .environment(\.verticalSizeClass, .compact)
            .previewLayout(.sizeThatFits)
            
            PermissionsInfoPopoverView(isPresented: .constant(true))
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            PermissionsInfoPopoverView(isPresented: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (4th generation)"))
        }
        .environmentObject(UserSettings())
    }
}

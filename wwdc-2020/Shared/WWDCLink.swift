//
//  WWDCLinkView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

struct WWDCLink: View {
    @EnvironmentObject var userSettings: UserSettings

    let title: String
    let url: String
    let image: String
    
    /// - Parameter image: the system image name
    init(title: String, url: String, image: String = "tv.circle") {
        self.title = title
        self.url = url
        self.image = image
    }
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Link(title, destination: URL(string: url)!)
        }
        .foregroundColor(userSettings.accentColor)
        .font(.headline)
    }
}

struct WWDCLinkView_Previews: PreviewProvider {
    static var previews: some View {
        WWDCLink(title: "Apple Developer", url: "https://developer.apple.com")
            .environmentObject(UserSettings())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

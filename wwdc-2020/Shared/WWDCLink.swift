//
//  WWDCLinkView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

struct WWDCLink: View {
    let title: String
    let url: String
    
    var body: some View {
        HStack {
            Image(systemName: "tv.circle")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            Link(title, destination: URL(string: url)!)
        }
        .font(.headline)
    }
}

struct WWDCLinkView_Previews: PreviewProvider {
    static var previews: some View {
        WWDCLink(title: "Apple Developer", url: "https://developer.apple.com")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

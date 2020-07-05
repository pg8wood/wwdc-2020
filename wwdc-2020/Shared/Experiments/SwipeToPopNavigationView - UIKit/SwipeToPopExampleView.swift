//
//  SwipeToPopExampleView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 7/5/20.
//

import SwiftUI

struct SwipeToPopExampleView: View {
    var body: some View {
        SwipeToPopNavigationView {
            NavigationLink(
                destination: Text("Swipe anywhere on the screen to close"),
                label: {
                    Text("Push view controller")
                })
                .navigationTitle("Swipe Back Nav")
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SwipeToPopExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeToPopExampleView()
    }
}

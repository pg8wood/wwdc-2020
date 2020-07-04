//
//  DragToDisissExampleView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 7/4/20.
//

import SwiftUI

struct DragToDisissExampleView: View {
    @State private var offset = CGSize.zero
        
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Drag right from anywhere to dismiss this view.")
            Text("Note: this currently isn't an interactive transition. Interactive transitions with NavigationView look very difficult in SwiftUI right now. I'll keep playing with it though 🤞")
                .font(.caption)
            Spacer()
        }
        .navigationTitle("Drag to Dismiss")
        .padding(.horizontal)
        .modifier(DragToDismiss())
    }
}

struct DraggableNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DragToDisissExampleView()
        }
        .environmentObject(UserSettings())
    }
}

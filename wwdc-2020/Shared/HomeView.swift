//
//  ContentView.swift
//  Shared
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var store: HomeListStore
    
    @State private var isStacksSectionShowing: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.exampleModels) { exampleModel in
                    Text(exampleModel.title)
                }
                
                DisclosureGroup(isExpanded: $isStacksSectionShowing) {
                    NavigationLink(destination: LazyVGridExample()) {
                        Text("Lazy VGrid Example")
                    }
                } label: {
                    Text("Stacks, Grids, and Outlines")
                }
            }
            .navigationTitle("WWDC 2020")
            
            Text("This Text view is the view that will show in iPad portrait mode before the user slides to reveal the above list.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(store: HomeListStore())
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
            
            HomeView(store: HomeListStore())
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (4th generation)"))
        }
    }
}

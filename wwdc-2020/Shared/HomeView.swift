//
//  ContentView.swift
//  Shared
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var store: HomeListStore
        
    var body: some View {
        NavigationView {
            List {
                WWDCLink(title: "App Essentials in SwiftUI", url: "https://developer.apple.com/wwdc20/10037")
                
                ForEach(store.exampleModels) { exampleModel in
                    Text(exampleModel.title)
                }
                                
                DisclosureGroup {
                    NavigationLink(destination: LazyVGridExample()) {
                        Text("Lazy VGrid Example")
                    }
                } label: {
                    Label("Stacks, Grids, and Outlines", systemImage: "square.grid.3x3.fill")
                        .labelStyle(VerticallyCenteredLabelImageAlignmentStyle()) // TODO: remove when Apple fixes the vertical alignment of the system image
                }
            }
            .navigationTitle("WWDC 2020")
            
            Text("This Text view is the view that will show in iPad portrait mode before the user slides to reveal the list, unless you add the `.navigationViewStyle(StackNavigationViewStyle())` modifier to the NavigationView.")
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

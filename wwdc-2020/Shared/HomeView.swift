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
            List(store.exampleModels) { exampleModel in
                Text(exampleModel.title)
            }
            .navigationTitle("WWDC 2020")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: HomeListStore())
    }
}

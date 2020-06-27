//
//  wwdc_2020App.swift
//  Shared
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI

@main
struct wwdc_2020App: App {
    @StateObject private var store = HomeListStore()
    
    var body: some Scene {
        WindowGroup {
            HomeView(store: store)
        }
    }
}

struct wwdc_2020App_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: HomeListStore())
    }
}

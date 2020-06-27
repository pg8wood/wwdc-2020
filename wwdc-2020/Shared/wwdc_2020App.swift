//
//  wwdc_2020App.swift
//  Shared
//
//  Created by Patrick Gatewood on 6/26/20.
//

import SwiftUI
import Combine

@main
struct wwdc_2020App: App {
    
    // Since this StateObject is at the App level, it's a source of truth that is shared with all the app's scenes
    @StateObject private var store = HomeListStore()
    @StateObject private var userSettings = UserSettings()
//    @State private var accentColor: Color = .blue
    
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(store)
                .environmentObject(userSettings)
                .accentColor(userSettings.accentColor)
        }
    }
}

struct wwdc_2020App_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: HomeListStore())
    }
}

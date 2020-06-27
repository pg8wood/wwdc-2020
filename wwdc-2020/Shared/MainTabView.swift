//
//  TabBarView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/27/20.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var store: HomeListStore
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        TabView {
            HomeView(store: store)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            SettingsView(accentColorString: $userSettings.accentColorString)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

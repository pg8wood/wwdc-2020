//
//  wwdc_2020App.swift
//  WWDC 2020 Extension
//
//  Created by Patrick Gatewood on 7/2/20.
//

import SwiftUI
//
@main
struct wwdc_2020App: App {

    // Since this StateObject is at the App level, it's a source of truth that is shared with all the app's scenes
    @StateObject private var store = HomeListStore()
    @StateObject private var userSettings = UserSettings()

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


//@main
//struct wwdc_2020App: App {
//    @SceneBuilder var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                ContentView()
//            }
//        }
//
//        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
//    }
//}

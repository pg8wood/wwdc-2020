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
                ForEach(store.exampleModels) { exampleModel in
                    Text(exampleModel.title)
                }
                HStack {
                    Text("Start here:")
                    WWDCLink(title: "App Essentials in SwiftUI", url: "https://developer.apple.com/wwdc20/10037")
                }
                                
                StackDisclosureGroup()
                PersistenceDisclosureGroup()
                ProgressViewsLink()
                CoreLocationLink()
                ExperimentsDisclosureGroup()
            }
            .navigationTitle("WWDC 2020")
            
            Text("This Text view is the view that will show in iPad portrait mode before the user slides to reveal the list, unless you add the `.navigationViewStyle(StackNavigationViewStyle())` modifier to the NavigationView.")
        }
    }
}

struct StackDisclosureGroup: View {
    @State private var isExpanded = true
    var body: some View {
        EasyExpandingDisclosureGroup(isExpanded: $isExpanded) {
            NavigationLink(destination: LazyVGridExample()) {
                Text("Lazy VGrid Example")
            }
        } label: {
            Label("Stacks, Grids, and Outlines", systemImage: "square.grid.3x3.fill")
                .labelStyle(VerticallyCenteredLabelImageAlignmentStyle()) // TODO: remove when Apple fixes the vertical alignment of the system image
        }
    }
}

struct PersistenceDisclosureGroup: View {
    var body: some View {
        EasyExpandingDisclosureGroup {
            NavigationLink(destination: SettingsView()) {
                Text("@AppStorage")
            }
        } label: {
            Label("Persistence", systemImage: "externaldrive")
                .labelStyle(VerticallyCenteredLabelImageAlignmentStyle())
        }
    }
}

struct ProgressViewsLink: View {
    var body: some View {
        NavigationLink(destination: ProgressViewExampleView()) {
            Label {
                Text("Progress Views")
                    .padding(.leading, 8)
            } icon: {
                ProgressView()
            }
            .labelStyle(VerticallyCenteredLabelImageAlignmentStyle())
        }
    }
}

struct CoreLocationLink: View {
    var body: some View {
        NavigationLink(destination: NewLocationPermissionsExampleView<LocationManager>()
                        .environmentObject(LocationManager())) {
            Label("Core Location Changes", systemImage: "mappin.circle")
                .labelStyle(VerticallyCenteredLabelImageAlignmentStyle())
        }
    }
}

struct ExperimentsDisclosureGroup: View {
    @State private var isShowingSwipeToPopSheet = false
    
    var body: some View {
        EasyExpandingDisclosureGroup {
            NavigationLink(destination: DragToDisissExampleView()) {
                Text("Swipe to pop NavigationView (pure SwiftUI)")
            }
            
            Button {
                isShowingSwipeToPopSheet = true
            } label: {
                Text("Swipe to pop NavigationView (with UIKit)")
            }
            .sheet(isPresented: $isShowingSwipeToPopSheet) {
                SwipeToPopExampleView()
            }
        } label: {
            Label("Experiments", systemImage: "eyes")
                .labelStyle(VerticallyCenteredLabelImageAlignmentStyle())
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
        .environmentObject(UserSettings())
    }
}

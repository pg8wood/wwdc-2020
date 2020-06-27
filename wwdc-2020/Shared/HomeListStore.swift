//
//  HomeListStore.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/26/20.
//

import Foundation

class HomeListStore: ObservableObject {
    var exampleModels = [
        SimpleExampleModel(title: "Hello world!"),
        SimpleExampleModel(title: "There's so much to learn at WWDC 😁")
    ]
}

struct SimpleExampleModel: Identifiable {
    let id = UUID()
    let title: String
}

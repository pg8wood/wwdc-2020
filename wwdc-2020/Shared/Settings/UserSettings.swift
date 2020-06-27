//
//  UserSettings.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/27/20.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @AppStorage("accentColor") var accentColorString = "blue" {
        willSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = PassthroughSubject<Void, Never>()
}

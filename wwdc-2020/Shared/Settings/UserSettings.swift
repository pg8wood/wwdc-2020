//
//  UserSettings.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/27/20.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    private var disposables = Set<AnyCancellable>()
    private var autoChangeColorTimer: AnyCancellable?
    
    @AppStorage("accentColor") var accentColorString = "blue" {
        willSet {
            objectWillChange.send()
        }
    }
    
    var accentColor: Color {
        AccentColor(rawValue: accentColorString)?.color ?? .blue
    }
    
    @AppStorage("autoUpdateAccentColor") var autoUpdateAccentColor = false {
        willSet {
            defer {
                objectWillChange.send()
            }
            
            if newValue {
                startChangingAccentColors(interval: autoUpdateAccentColorInterval)
            } else {
                autoChangeColorTimer?.cancel()
            }
        }
    }
    
    @AppStorage("autoUpdateAccentColorInterval") var autoUpdateAccentColorInterval: Double = 1 {
        willSet {
            defer {
                objectWillChange.send()
            }
            
            // Sadly we can't just change the timer's interval, so we have to
            // make a whole new timer
            startChangingAccentColors(interval: newValue)
        }
    }
    
    // MARK: - init
    
    init() {
        if autoUpdateAccentColorInterval > 0 {
            startChangingAccentColors(interval: autoUpdateAccentColorInterval)
        }
    }
    
    private func startChangingAccentColors(interval: Double) {
        func advanceToNextAccentColor() {
            var nextColorIndex = 0
            if let currentColor = AccentColor(rawValue: accentColorString) {
                nextColorIndex = (currentColor.index + 1) % AccentColor.allCases.count
            }
            
            let nextColor = AccentColor.allCases[nextColorIndex]
            accentColorString = nextColor.rawValue
        }
        
        autoChangeColorTimer = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink() { _ in
                advanceToNextAccentColor()
            }
    }
}

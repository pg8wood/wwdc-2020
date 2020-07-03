//
//  LoadingMessageProgressView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 7/3/20.
//

import SwiftUI
import Combine

struct LoadingMessageProgressView: View {
    @State private var cancellables = Set<AnyCancellable>()
    @State private var messageIndex = 0
    
    private var messages = [
        "Loading...",
        "Still loading...",
        "STILL loading...",
        "Is anybody there?",
        "I'm so lonely"
    ]
    
    private var currentMessage: String {
        messages[messageIndex % messages.count]
    }
    
    var body: some View {
        ProgressView {
            Text(currentMessage)
                .frame(minWidth: 0, maxWidth: .infinity)
                .id("LoadingMessageViewText: \(currentMessage)")
                .transition(.slide)
                .animation(.default)
        }
        .onAppear {
            Timer.publish(every: 3, on: .main, in: .common)
                .autoconnect()
                .sink() { _ in
                    withAnimation {
                        messageIndex += 1
                    }
                }
                .store(in: &cancellables)
        }
    }
}

struct LoadingMessageProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingMessageProgressView()
    }
}

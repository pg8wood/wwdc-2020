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
        "Is anybody there?",
        "I'm so lonely"
    ]
    
    private var imageNames = [
        "kermit-thinking",
        "kermit-fishing",
        "kermit-rain"
    ]
    
    private var currentMessage: String {
        messages[messageIndex % messages.count]
    }
    
    
    private var loadingMessages: [AnyView] = {
        func loadingImage(_ name: String) -> some View {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous))
        }
        
        func loadingText(_ text: String ) -> some View {
            Text(text)
                .frame(width: 200, height: 200, alignment: .top)
        }
        
        return [
            loadingText("Loading..."),
            loadingText("Is anybody there?"),
            loadingText("I'm some lonely"),
            loadingImage("kermit-thinking"),
            loadingImage("kermit-fishing"),
            loadingImage("kermit-rain")
        ]
        .compactMap { AnyView(_fromValue: $0) }
    }()
    
    
    private var currentLoadingMessage: some View {
        loadingMessages[messageIndex % loadingMessages.count]
    }
    
    var body: some View {
        ProgressView {
            currentLoadingMessage
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
                .id("LoadingMessageViewText: \(currentMessage)") // will tell SwiftUI to use the transition even if the view is changing to a view of the same type (i.e. Image --> Image)
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

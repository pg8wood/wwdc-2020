//
//  ProgressViews.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/30/20.
//
// An attempt at creating my own type erasure similar to `AnyView`. Not recommended
// unless we figure out a way to restore `AnyProgressviewStyle`'s wrapped view's type.
// See:https://forums.swift.org/t/why-some-swiftui-views-have-body-swift-never/27372/8

import SwiftUI
import Combine

struct ProgressViewExampleView: View {
    @State private var cancellables = Set<AnyCancellable>()
    @State private var downloadAmount = 0.0
    
    /// Don't do this moving forward. See: [AnyProgressViewStyle](x-source-tag://AnyProgressViewStyle) for more info
    @State private var currentProgressViewStyle: ProgressStyle = .default
    
    enum ProgressStyle: String, CaseIterable {
        case `default` = "Default"
        case linear = "Linear"
        case circular = "Circular"
        
        var body: some ProgressViewStyle {
            switch self {
            case .default:
                return AnyProgressViewStyle(DefaultProgressViewStyle())
            case .linear:
                return AnyProgressViewStyle(LinearProgressViewStyle())
            case .circular:
                return AnyProgressViewStyle(CircularProgressViewStyle())
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Progress View Style") // label isn't rendered with SegmentedPickerStyle, so we need one here
                .font(.headline)
            Picker(selection: $currentProgressViewStyle, label: Text("Progress View Style")) {
                ForEach(ProgressStyle.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
    
            Text("The default style will vary based on the platform.")
                .font(.caption2)
                .padding(.bottom, 20)

            ProgressView("Downloading…", value: downloadAmount, total: 100)
                .progressViewStyle(currentProgressViewStyle.body)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.bottom, 30)
                        
            Text("Custom Progress View")
                .font(.headline)
                .padding(.bottom, 30)
            LoadingMessageProgressView()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Progress Views")
        .onAppear {
            Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink() { _ in
                    downloadAmount = (downloadAmount + 2).truncatingRemainder(dividingBy: 100)
                }
                .store(in: &cancellables)
        }
    }
}

struct ProgressViews_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewExampleView()
    }
}

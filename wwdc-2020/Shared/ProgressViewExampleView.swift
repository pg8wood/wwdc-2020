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

// MARK: - Type Erasure

protocol TypeErasing {
    var erasedValue: Any { get }
}

struct ProgressViewStyleTypeEraser<S: ProgressViewStyle>: TypeErasing {
    let style: S
    var erasedValue: Any {
        style
    }
}

// MARK: - Type-erased `ProgressViewStyle` attempt

/// After some research, it seems this isn't possible yet without leveraging SwiftUI's internal implementations.
/// See: https://forums.swift.org/t/why-some-swiftui-views-have-body-swift-never/27372/8
struct AnyProgressViewStyle: ProgressViewStyle {
    private var eraser: TypeErasing
    
    init<S>(_ style: S) where S : ProgressViewStyle {
        eraser = ProgressViewStyleTypeEraser(style: style)
    }
    
    private var wrappedStyle: Any {
        eraser.erasedValue
    }
        
    /// In AnyView, this type is Never, telling SwiftUI to internally call its wrapped subview's `body` instead.
    typealias Body = AnyView
    
    func makeBody(configuration: Self.Configuration) -> Self.Body {
        // See the AnyProgressViewStyle documentation for why we have to do this.
        // Overall, this is not a pattern I'd recommend using moving forward.
        if let style = wrappedStyle as? DefaultProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        } else if let style = wrappedStyle as? CircularProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        } else if let style = wrappedStyle as? LinearProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        }

        fatalError("Need to figure out to to restore the type of ProgressViewStyle!")
    }
}

// MARK: - The example view which made me want to attempt to make my own type erasure

struct ProgressViewExampleView: View {
    @State private var cancellables = Set<AnyCancellable>()
    @State private var downloadAmount = 0.0
    
    // The offender. Since `ProgressViewStyle` has associated type constraints, we
    // can't store a state variable of type `ProgressViewStyle`
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

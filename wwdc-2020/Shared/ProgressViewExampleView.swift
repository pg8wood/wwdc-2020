//
//  ProgressViews.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/30/20.
//

import SwiftUI
import Combine

protocol TypeErasing {
    var erasedValue: Any { get }
}

struct ProgressViewStyleTypeEraser<S: ProgressViewStyle>: TypeErasing {
    let style: S
    var erasedValue: Any {
        style
    }
}

struct AnyProgressViewStyle: ProgressViewStyle {
    private var innerStyle: some ProgressViewStyle = DefaultProgressViewStyle()
    
    private var eraser: TypeErasing
    public init<S>(_ style: S) where S : ProgressViewStyle {
        eraser = ProgressViewStyleTypeEraser(style: style)
    }
    
    private var wrappedStyle: Any {
        eraser.erasedValue
    }
    
    // MARK: - ProgressViewStyle
    
    typealias Body = AnyView
    
    func makeBody(configuration: Self.Configuration) -> Self.Body {
        // TODO: Figure out how AnyView works with respect to reconstituting the type of View it wraps and mirros
        // that functionality here instead of casting
        
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

struct ProgressViewExampleView: View {
    @State private var cancellables = Set<AnyCancellable>()
    @State private var currentProgressViewStyle: ProgressStyle = .default
    @State private var downloadAmount = 0.0
    
    enum ProgressStyle: String, CaseIterable {
        case `default` = "Default"
        case linear = "Linear"
        case circular = "Circular"
        // TODO: custom style
        
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

//
//  ProgressViews.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/30/20.
//

import SwiftUI

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
        if let style = wrappedStyle as? DefaultProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        } else if let style = wrappedStyle as? CircularProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        } else if let style = wrappedStyle as? LinearProgressViewStyle {
            return AnyView(style.makeBody(configuration: configuration))
        }
        
        fatalError()
    }
}

struct ProgressViewExampleView: View {
    
    @State private var progress = 0.5
    
    @State private var downloadAmount = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
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
    
    @State private var currentProgressViewStyle: ProgressStyle = .default
    
    var body: some View {
        VStack {
            Picker(selection: $currentProgressViewStyle, label: Text("Progress View Style")) {
                ForEach(ProgressStyle.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            ProgressView("Default Progress View", value: progress)
                .progressViewStyle(currentProgressViewStyle.body)
            
            Button("More", action: { progress += 0.05 })
            
            ProgressView("Downloading…", value: downloadAmount, total: 100)
                .progressViewStyle(currentProgressViewStyle.body)
                .onReceive(timer) { _ in
                    downloadAmount = (downloadAmount + 2).truncatingRemainder(dividingBy: 100)
                }
        }
        .padding()
    }
}

struct ProgressViews_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewExampleView()
//            .previewLayout(.sizeThatFits)
    }
}

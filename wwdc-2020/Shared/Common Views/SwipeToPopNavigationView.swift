//
//  SwipeToPopNavigationView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 7/5/20.
//

import SwiftUI

struct SwipeToPopNavigationView<Content>: UIViewControllerRepresentable where Content: View {
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        let hostingController = UIHostingController(rootView: content())
        return SwipeToPopNavigationController(rootViewController: hostingController)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Nothing to do... yet
    }
}

/// A UINavigationController that allows swipe-back-from-anywhere.
/// Adapted from  https://stackoverflow.com/questions/35388985/how-can-i-implement-drag-right-to-dismiss-a-view-controller-thats-in-a-naviga/35510861#35510861
private class SwipeToPopNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        setupFullWidthBackGesture()
    }
    
    /// Uses some undocumented API. TODO: - work on another implementation that doesn't use undocumented API
    private func setupFullWidthBackGesture() {
        guard let interactivePopGestureRecognizer = interactivePopGestureRecognizer,
              let targets = interactivePopGestureRecognizer.value(forKey: "targets") else {
            return
        }
        
        fullWidthBackGestureRecognizer.setValue(targets, forKey: "targets")
        fullWidthBackGestureRecognizer.delegate = self
        view.addGestureRecognizer(fullWidthBackGestureRecognizer)
    }

    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let isSystemSwipeToBackEnabled = interactivePopGestureRecognizer?.isEnabled == true
        return isSystemSwipeToBackEnabled && viewControllers.count > 1
    }
}

struct SwipeToCloseNavigationController_Previews: PreviewProvider {
    static var previews: some View {
        SwipeToPopNavigationView {
            NavigationLink(
                destination: Text("Swipe back to close"),
                label: {
                    Text("Push view controller")
                })
                .navigationTitle("Swipe Back Nav")
        }
    }
}

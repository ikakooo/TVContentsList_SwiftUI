//
//  OrientationObserver.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/3/24.
//

import SwiftUI
import Combine

class OrientationObserver: ObservableObject {
    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation
    
    private var orientationDidChangeNotification: AnyCancellable?

    init() {
        orientationDidChangeNotification = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { $0.object as? UIDevice }
            .map { $0.orientation }
            .assign(to: \.orientation, on: self)
    }
}


extension UIDeviceOrientation {
    var isPortrait: Bool {
        return self == .portrait || self == .portraitUpsideDown
    }

    var isLandscape: Bool {
        return self == .landscapeLeft || self == .landscapeRight
    }
}

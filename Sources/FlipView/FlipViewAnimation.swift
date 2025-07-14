//
//  FlipViewAnimation.swift
//  FlipKit
//
//  Created by Daniel Saidi on 2025-07-14.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines supported flip view animation types.
///
/// The enum can use native animations that support duration.
///
/// You can apply a custom flip view animation with the view
/// modifier ``SwiftUICore/View/flipViewAnimation(_:duration:)``.
public enum FlipViewAnimation: String, Codable, Hashable, Sendable {

    /// A bouncy animation.
    case bouncy

    /// An ease out animation.
    case easeOut

    /// A linear animation.
    case linear

    /// A smooth animation.
    case smooth

    /// A snappy animation.
    case snappy

    /// A spring animation.
    case spring
}

/// This internal type defines an animation and a duration.
struct FlipViewAnimationValue {

    let animationType: FlipViewAnimation
    let duration: TimeInterval

    var animation: Animation {
        switch animationType {
        case .bouncy: .bouncy(duration: duration)
        case .easeOut: .easeOut(duration: duration)
        case .linear: .linear(duration: duration)
        case .smooth: .smooth(duration: duration)
        case .snappy: .snappy(duration: duration)
        case .spring: .spring(duration: duration)
        }
    }
}

extension EnvironmentValues {

    @Entry var flipViewAnimation = FlipViewAnimationValue(animationType: .linear, duration: 0.2)
}

public extension View {

    /// Apply a custom ``FlipViewAnimation`` type.
    ///
    /// - Parameters:
    ///   - animation: The animation to use.
    ///   - duration: The animation duration, by default `0.2`.
    func flipViewAnimation(
        _ animation: FlipViewAnimation,
        duration: TimeInterval = 0.2
    ) -> some View {
        self.environment(\.flipViewAnimation, .init(animationType: animation, duration: duration))
    }
}

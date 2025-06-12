//
//  FlipKit.swift
//  FlipKit
//
//  Created by Daniel Saidi on 2020-01-05.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view has a front and a back view and can be flipped
/// to show the other side when it's tapped or swiped.
///
/// > Important: This view currently handles flip animations
/// incorrectly when it is used within a `List`. This can be
/// fixed by wrapping it in a `ZStack`. I tried to create an
/// additional layer within this component, but that did not
/// work. Until we come up with another solution, there is a
/// temp ``FlipKit/View/withListRenderingBugFix()`` view
/// modifier that performs the `ZStack` wrapping.
public struct FlipView<FrontView: View, BackView: View>: View {

    /// Create a flip view with content view values.
    ///
    /// - Parameters:
    ///   - isFlipped: The flipped state.
    ///   - flipDuration: The duration of the flip, by deffault `0.3`.
    ///   - tapDirection: The direction to flip on tap, by default `.right`.
    ///   - flipDirections: The supported flip directions, by default `.allCases`.
    ///   - front: The front view.
    ///   - back: The back view.
    public init(
        front: FrontView,
        back: BackView,
        isFlipped: Binding<Bool>,
        flipDuration: Double? = nil,
        tapDirection: FlipDirection? = nil,
        flipDirections: [FlipDirection]? = nil
    ) {
        self.init(
            isFlipped: isFlipped,
            flipDuration: flipDuration,
            tapDirection: tapDirection,
            flipDirections: flipDirections,
            front: { front },
            back: { back }
        )
    }
    
    /// Create a flip view with content view builders.
    ///
    /// - Parameters:
    ///   - isFlipped: The flipped state.
    ///   - flipDuration: The duration of the flip, by deffault `0.3`.
    ///   - tapDirection: The direction to flip on tap, by default `.right`.
    ///   - flipDirections: The supported flip directions, by default `.allCases`.
    ///   - front: The front view.
    ///   - back: The back view.
    public init(
        isFlipped: Binding<Bool>,
        flipDuration: Double? = nil,
        tapDirection: FlipDirection? = nil,
        flipDirections: [FlipDirection]? = nil,
        @ViewBuilder front: @escaping () -> FrontView,
        @ViewBuilder back: @escaping () -> BackView,
    ) {
        self.front = front
        self.back = back
        self._isFlipped = isFlipped
        self.flipDuration = flipDuration ?? 0.3
        self.tapDirection = tapDirection ?? .right
        self.flipDirections = flipDirections ?? .allCases

        let isFlippedValue = isFlipped.wrappedValue
        self._isContentFlipped = .init(initialValue: isFlippedValue)
    }

    @Binding private var isFlipped: Bool

    private let front: () -> FrontView
    private let back: () -> BackView
    private let flipDuration: Double
    private let flipDirections: [FlipDirection]
    private let tapDirection: FlipDirection

    @State private var cardRotation = 0.0
    @State private var contentRotation = 0.0
    @State private var isContentFlipped: Bool {
        didSet { isFlipped = isContentFlipped }
    }
    @State private var isFlipping = false
    @State private var lastDirection = FlipDirection.right

    public var body: some View {
        bodyContent
            .onChange(of: isFlipped) { _, _ in flipWithTap() }
            .withTapGesture(action: flipWithTap)
            .withSwipeGesture(action: flipWithSwipe)
            .rotationEffect(.degrees(contentRotation), direction: lastDirection)
            .rotationEffect(.degrees(cardRotation), direction: lastDirection)
            .accessibility(addTraits: .isButton)
    }

    @ViewBuilder
    var bodyContent: some View {
        if isContentFlipped {
            back()
        } else {
            front()
        }
    }
}

public extension View {

    /// Apply this to a ``FlipView`` to make it perform well
    /// within a List.
    func withListRenderingBugFix() -> some View {
        ZStack {
            self
        }
    }
}

private extension View {

    typealias FlipAction = (FlipDirection) -> Void

    func withTapGesture(action: @escaping () -> Void) -> some View {
        #if os(tvOS)
        Button(action: action) { self }
            .buttonStyle(.plain)
        #else
        self.onTapGesture(perform: action)
        #endif
    }

    func withSwipeGesture(action: @escaping FlipAction) -> some View {
        #if os(tvOS)
        self
        #else
        self.onFlipGesture(
            up: { action(.up) },
            left: { action(.left) },
            right: { action(.right) },
            down: { action(.down) })
        #endif
    }
}

private extension FlipView {

    func flip(_ direction: FlipDirection) {
        guard !isFlipping else { return }
        isFlipping = true
        lastDirection = direction
        cardRotation = isContentFlipped ? 180 : 0
        contentRotation = isContentFlipped ? 180 : 0

        let duration = flipDuration/2
        let animation = Animation.linear(duration: duration)

        let degrees = flipDegrees(for: direction)
        withAnimation(animation) {
            cardRotation += degrees/2
        } completion: {
            contentRotation += degrees
            isContentFlipped.toggle()
            withAnimation(animation) {
                cardRotation += degrees/2
            } completion: {
                isFlipping = false
            }
        }
    }

    func flipDegrees(for direction: FlipDirection) -> Double {
        switch direction {
        case .right, .up: 180
        case .left, .down: -180
        }
    }

    func flipWithTap() {
        flip(tapDirection)
    }

    func flipWithSwipe(in direction: FlipDirection) {
        guard flipDirections.contains(direction) else { return }
        flip(direction)
    }
}

private extension View {

    @ViewBuilder
    func rotationEffect(
        _ angles: Angle,
        direction: FlipDirection
    ) -> some View {
        switch direction {
        case .left, .right: rotation3DEffect(angles, axis: (x: 0, y: 1, z: 0))
        case .up, .down: rotation3DEffect(angles, axis: (x: 1, y: 0, z: 0))
        }
    }
}

@MainActor
@ViewBuilder
func previewContent(isFlipped: Binding<Bool>) -> some View {
    Text("Is Flipped: \(isFlipped.wrappedValue)")

    FlipView(
        front: Color.green.overlay(Text("Front")),
        back: Color.red.overlay(Text("Back")),
        isFlipped: isFlipped,
        flipDuration: 0.2,
        tapDirection: .right,
        flipDirections: [.left, .right, .up, .down]
    )
    .withListRenderingBugFix()  // OBS!
    .frame(minHeight: 100)
    .cornerRadius(10)
    .shadow(radius: 0, x: 0, y: 2)

    Button("Flip") {
        withAnimation {
            isFlipped.wrappedValue.toggle()
        }
    }
}

#Preview("Stack") {

    struct Preview: View {

        @State
        private var isFlipped = false

        var body: some View {
            VStack {
                previewContent(isFlipped: $isFlipped)
            }
            .padding()
        }
    }

    return Preview()
}

#Preview("List Bugfix") {

    struct Preview: View {

        @State
        private var isFlipped = false

        var body: some View {
            List {
                previewContent(isFlipped: $isFlipped)
            }
            .padding()
        }
    }

    return Preview()
}

import FlipKit
import SwiftUI
import Testing

@MainActor
@Test func allPublicTypesCanBeCreated() async throws {
    _ = FlipDirection.down
    #if os(iOS)
    _ = FlipGestureViewModifier()
    #endif
    _ = FlipViewAnimation.linear
    _ = FlipView(
        isFlipped: .constant(true),
        front: { Color.green },
        back: { Color.red }
    )
    .flipViewAnimation(.bouncy, duration: 1)
}

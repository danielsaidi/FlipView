import FlipKit
import SwiftUI
import Testing

@MainActor
@Test func allPublicTypesCanBeCreated() async throws {
    _ = FlipDirection.down
    #if os(iOS)
    _ = await FlipGestureViewModifier()
    #endif
    _ = FlipViewAnimation.linear
    _ = FlipView(
        isFlipped: .constant(true),
        content: { _ in Color.green }
    )
    .flipViewAnimation(.bouncy, duration: 1)
}

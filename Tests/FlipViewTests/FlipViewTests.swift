import FlipKit
import SwiftUI
import Testing

@Test func allPublicTypesCanBeCreated() async throws {
    _ = FlipDirection.down
    _ = await FlipGestureViewModifier()
    _ = await FlipView(
        isFlipped: .constant(true),
        front: { Color.green },
        back: { Color.red },
    )
}

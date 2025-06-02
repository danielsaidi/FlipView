//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-02.
//

import FlipKit
import SwiftUI

struct ContentView: View {

    @State private var isFlipped = false

    var body: some View {
        FlipView(
            isFlipped: $isFlipped,
            flipDuration: 0.3,
            front: { Card(.green) },
            back: { Card(.red) }
        )
        .padding()
    }
}

struct Card: View {

    init(_ color: Color) {
        self.color = color
    }

    private let color: Color

    var body: some View {
        color.cornerRadius(10)
    }
}

#Preview {
    ContentView()
}

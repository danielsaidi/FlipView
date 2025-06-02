//
//  FlipDirection.swift
//  FlipKit
//
//  Created by Daniel Saidi on 2020-01-05.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This enum defines the supported flip directions that can
/// be used with a ``FlipView``.
public enum FlipDirection: CaseIterable {

    case left, right, up, down
}

public extension Collection where Element == FlipDirection {
    
    static var allCases: [Element] { Element.allCases }
}

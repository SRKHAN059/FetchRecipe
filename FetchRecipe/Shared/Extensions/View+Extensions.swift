//
//  View+Extensions.swift
//  FetchRecipe
//
//  Created by Shifath Khan on 1/27/25.
//

import SwiftUI

extension View {
    func padding(_ edges: Edge.Set, _ padding: Padding) -> some View {
        self.padding(edges, padding.rawValue)
    }
}

// MARK: - Padding

struct Padding: RawRepresentable {
    public var rawValue: CGFloat
    
    public init(rawValue: CGFloat) {
        self.rawValue = rawValue
    }
    
    // MARK: Padding Values
    public static var zero: Padding { .init(rawValue: 0) }
    public static var small: Padding { .init(rawValue: 4) }
    public static var standard: Padding { .init(rawValue: 8) }
    public static var large: Padding { .init(rawValue: 16) }
}

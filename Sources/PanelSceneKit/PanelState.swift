/*
 PanelState.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/04.
*/

import SwiftUI

@MainActor @propertyWrapper public struct PanelState: DynamicProperty, Sendable {
    @State var store: PanelStateStore

    public var wrappedValue: Bool {
        get { store.isPresented }
        nonmutating set { store.isPresented = newValue }
    }

    public var projectedValue: Binding<Bool> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(wrappedValue: Bool, _ key: String) {
        store = .init(panelKey: key, isPresented: wrappedValue)
    }
}

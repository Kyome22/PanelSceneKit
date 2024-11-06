/*
 PanelScene.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/02.
*/

import SwiftUI

public struct PanelScene<Panel: HostingPanel, Content: View>: Scene {
    @Binding var isPresented: Bool
    @ViewBuilder let content: ([AnyHashable: Any]?) -> Content

    public init(isPresented: Binding<Bool>, type: Panel.Type, @ViewBuilder content: @escaping ([AnyHashable: Any]?) -> Content) {
        _isPresented = isPresented
        self.content = content
    }

    public var body: some Scene {
        ModifiedContent(
            content: _EmptyScene(),
            modifier: PanelSceneModifier<Panel, Content>(isPresented: $isPresented, viewContent: content)
        )
    }
}

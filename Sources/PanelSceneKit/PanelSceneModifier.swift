/*
 PanelSceneModifier.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/02.
*/

import SwiftUI

@MainActor struct PanelSceneModifier<Panel: HostingPanel, ViewContent: View>: @preconcurrency _SceneModifier {
    @State var sceneRepresentable: PanelSceneRepresentable<Panel>
    @Binding var isPresented: Bool
    @ViewBuilder let viewContent: ([AnyHashable: Any]?) -> ViewContent

    init(isPresented: Binding<Bool>, viewContent: @escaping ([AnyHashable: Any]?) -> ViewContent) {
        sceneRepresentable = .init(closeAction: {
            isPresented.wrappedValue = false
        })
        _isPresented = isPresented
        self.viewContent = viewContent
    }

    func body(content: SceneContent) -> some Scene {
        content.onChange(of: isPresented, initial: true) { _, newValue in
            if newValue {
                sceneRepresentable.open(content: viewContent(PanelStateStore.userInfo))
            } else {
                sceneRepresentable.close()
            }
        }
    }
}

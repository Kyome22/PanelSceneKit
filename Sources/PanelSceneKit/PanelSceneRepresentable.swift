/*
 PanelSceneRepresentable.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/02.
*/

import SwiftUI

@MainActor final class PanelSceneRepresentable<Panel: HostingPanel>: NSObject, NSWindowDelegate {
    var panel: Panel?
    var closeAction: () -> Void

    init(closeAction: @escaping () -> Void) {
        self.closeAction = closeAction
    }

    func open<Content: View>(content: @autoclosure @escaping () -> Content) {
        if panel == nil {
            panel = .init(content: content)
            panel?.delegate = self
            panel?.center()
            panel?.orderFrontRegardless()
        }
    }

    func close() {
        panel?.close()
    }

    func windowWillClose(_ notification: Notification) {
        if let window = notification.object as? NSWindow, window === panel {
            panel = nil
            closeAction()
        }
    }
}

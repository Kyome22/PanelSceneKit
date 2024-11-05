/*
 FloatingPanel.swift
 Example

 Created by Takuto Nakamura on 2024/11/04.
*/

import PanelSceneKit
import SwiftUI

final class FloatingPanel: NSPanel, HostingPanel {
    init<Content: View>(content: () -> Content) {
        super.init(
            contentRect: .zero,
            styleMask: [.titled, .closable, .fullSizeContentView, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        level = .floating
        isOpaque = false
        isMovableByWindowBackground = true
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        animationBehavior = .utilityWindow
        contentView = NSHostingView(rootView: content())
    }
}

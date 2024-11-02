/*
 HostingPanel.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/02.
*/

import SwiftUI

public protocol HostingPanel: NSPanel {
    init<Content: View>(@ViewBuilder content: @escaping () -> Content)
}

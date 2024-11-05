/*
 PanelStateStore.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/04.
*/

import Foundation
import Observation

@MainActor @Observable final class PanelStateStore {
    @ObservationIgnored private var task: Task<Void, Never>?
    var panelKey: String
    var isPresented: Bool

    init(panelKey: String, isPresented: Bool) {
        self.panelKey = panelKey
        self.isPresented = isPresented
        task = Task {
            for await notification in NotificationCenter.default.publisher(for: .didRequestPanelAction).values {
                if let panelKey = notification.userInfo?["panelKey"] as? String,
                   panelKey == self.panelKey,
                   let action = notification.userInfo?["action"] as? PanelAction {
                    self.isPresented = action == .open
                }
            }
        }
    }

    deinit {
        task?.cancel()
    }
}

extension Notification: @unchecked Sendable { }

/*
 PanelStateStore.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/04.
*/

import Foundation
import Observation

@MainActor @Observable final class PanelStateStore {
    static var userInfo: [AnyHashable: Any]?

    @ObservationIgnored private var task: Task<Void, Never>?
    var panelKey: String
    var isPresented: Bool

    init(panelKey: String, isPresented: Bool) {
        self.panelKey = panelKey
        self.isPresented = isPresented
        task = Task {
            for await notification in NotificationCenter.default.publisher(for: .didRequestPanelAction).values {
                guard var userInfo = notification.userInfo,
                      let panelKey = userInfo.removeValue(forKey: "panelKey") as? String,
                      let action = userInfo.removeValue(forKey: "action") as? PanelAction,
                      panelKey == self.panelKey else {
                    continue
                }
                Self.userInfo = if action == .open {
                    userInfo
                } else {
                    nil
                }
                self.isPresented = action == .open
            }
        }
    }

    deinit {
        task?.cancel()
    }
}

extension Notification: @unchecked Sendable { }

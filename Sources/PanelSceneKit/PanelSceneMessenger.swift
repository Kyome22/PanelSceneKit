/*
 PanelSceneMessenger.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/04.
*/

import Foundation

public struct PanelSceneMessenger {
    public static func request(panelAction: PanelAction, with key: String, userInfo: [AnyHashable : Any]? = nil) {
        var _userInfo: [AnyHashable : Any] = userInfo ?? [:]
        _userInfo.merge([
            "panelKey": key,
            "action": panelAction
        ]) { $1 }
        NotificationCenter.default.post(name: .didRequestPanelAction, object: nil, userInfo: _userInfo)
    }
}

/*
 PanelSceneMessenger.swift
 PanelSceneKit

 Created by Takuto Nakamura on 2024/11/04.
*/

import Foundation

public struct PanelSceneMessenger {
    public static func request(panelAction: PanelAction, with key: String) {
        let userInfo: [String : Any] = [
            "panelKey": key,
            "action": panelAction
        ]
        NotificationCenter.default.post(name: .didRequestPanelAction, object: nil, userInfo: userInfo)
    }
}

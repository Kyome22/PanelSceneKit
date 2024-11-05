/*
 ExampleApp.swift
 Example

 Created by Takuto Nakamura on 2024/11/04.
*/

import PanelSceneKit
import SwiftUI

@main
struct ExampleApp: App {
    @PanelState("SomePanelKey") var isPresented: Bool = false

    var body: some Scene {
        WindowGroup {
            Toggle(isOn: Binding<Bool>(
                get: { isPresented },
                set: {
                    let action: PanelAction = $0 ? .open : .close
                    PanelSceneMessenger.request(panelAction: action, with: "SomePanelKey")
                }
            )) {
                Text("Show Panel")
            }
            .fixedSize()
            .padding()
        }
        .windowResizability(.contentSize)
        PanelScene(isPresented: $isPresented, type: FloatingPanel.self) {
            Text("Hello World!").fixedSize().padding()
        }
    }
}

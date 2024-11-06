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
                    let number = Int.random(in: 0 ..< 10)
                    PanelSceneMessenger.request(panelAction: action, with: "SomePanelKey", userInfo: ["number": number])
                }
            )) {
                Text("Show Panel")
            }
            .fixedSize()
            .padding()
        }
        .windowResizability(.contentSize)
        PanelScene(isPresented: $isPresented, type: FloatingPanel.self) { userInfo in
            if let number = userInfo?["number"] as? Int {
                Text("Hello World! \(number)").fixedSize().padding()
            } else {
                Text("Hello World!").fixedSize().padding()
            }
        }
    }
}

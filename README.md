# PanelSceneKit

Library that provides NSPanel via SwiftUI Scene.

## Requirements

- Development with Xcode 16.0+
- Written in Swift 6.0
- Compatible with macOS 14.0+

## Usage

Below is an example of displaying a custom `NSPanel` with a floating attribute.

```swift
@main
struct SampleApp: App {
    @State var isPresented: Bool = true

    var body: some Scene {
        PanelScene(isPresented: $isPresented, type: FloatingPanel.self) {
            Text("Hello World!")
                .fixedSize()
                .padding()
        }
    }
}
```

You need to define a custom `NSPanel` that conforms to `HostingPanel`.

```swift
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
```

You can toggle the visibility of the specified PanelScene from a remote scope.

```diff swift
@main
struct SampleApp: App {
+   @PanelState("SomePanelKey") var isPresented: Bool = false

    var body: some Scene {
        PanelScene(isPresented: $isPresented, type: FloatingPanel.self) {
            Text("Hello World!")
                .fixedSize()
                .padding()
        }
    }
}

// Request to open the specified PanelScene.
PanelSceneMessenger.request(panelAction: .open, with: "SomePanelKey")

// Request to close the specified PanelScene.
PanelSceneMessenger.request(panelAction: .close, with: "SomePanelKey")
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

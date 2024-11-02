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

You need to define a custom `NSPanel` that is compliant with `HostingPanel`.

```swift
public final class FloatingPanel: NSPanel, HostingPanel {
    public init<Content: View>(content: () -> Content) {
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

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

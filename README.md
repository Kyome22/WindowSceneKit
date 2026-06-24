# WindowSceneKit

Providing NSWindow via SwiftUI Scene.

## Requirements

- Development with Xcode 26.2+
- Written in Swift 6.2
- Compatible with macOS 14.0+

## Usage

Below is an example of displaying a custom `NSWindow`.

```swift
@main
struct SampleApp: App {
    @WindowState("SomeWindowKey") var isPresented = true

    var body: some Scene {
        WindowScene(isPresented: $isPresented, window: { _ in
            CustomWindow(content: { ContentView() })
        })
    }
}
```

```swift
final class CustomWindow: NSWindow {
    init<Content: View>(@ViewBuilder content: () -> Content) {
        super.init(
            contentRect: .zero,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        level = .floating
        collectionBehavior = [.canJoinAllSpaces]
        contentView = NSHostingView(rootView: content())
    }
}
```

You can toggle the visibility of the specified WindowScene from a remote scope.

```swift
// Request to open the specified WindowScene.
WindowSceneMessenger.request(windowAction: .open, windowKey: "SomeWindowKey")

// Request to close the specified WindowScene.
WindowSceneMessenger.request(windowAction: .close, windowKey: "SomeWindowKey")
```

Additionally, you can submit supplementary information.

```swift
WindowSceneMessenger.request(
    windowAction: .open, 
    windowKey: "SomeWindowKey",
    supplements: ["name": "Sakura"]
)

@main
struct SampleApp: App {
    @WindowState("SomeWindowKey") var isPresented = true

    var body: some Scene {
        WindowScene(isPresented: $isPresented, window: { supplements in
            CustomWindow(content: { ContentView(name: supplements["name"] as? String) })
        })
    }
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

# WindowSceneKit

Providing NSWindow via SwiftUI Scene.

## Requirements

- Development with Xcode 26.2+
- Written in Swift 6.2
- Compatible with macOS 14.0+

## Usage

First, define a `WindowSceneKey`.
The key carries the type of its payload, and its id string must be unique across all windows.
If a window does not need a payload, use `Void` as the payload type.

```swift
extension WindowSceneKey where Payload == Void {
    static var custom: Self { .init("CustomWindow") }
}
```

Below is an example of displaying a custom `NSWindow`.

```swift
@main
struct SampleApp: App {
    @WindowState(.custom) var isPresented = true

    var body: some Scene {
        WindowScene(isPresented: $isPresented, key: .custom) { _ in
            CustomWindow(content: { ContentView() })
        }
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
WindowSceneMessenger.request(.open, for: .custom)

// Request to close the specified WindowScene.
WindowSceneMessenger.request(.close, for: .custom)
```

Additionally, you can submit a payload.
Define a key whose `Payload` is your own `Sendable` type.
Because the key carries the payload type, the payload is delivered to the `window` closure fully typed — no casting required.

```swift
struct CustomPayload: Sendable {
    let name: String
}

extension WindowSceneKey where Payload == CustomPayload {
    static var custom: Self { .init("CustomWindow") }
}

WindowSceneMessenger.request(.open, for: .custom, payload: CustomPayload(name: "Sakura"))

@main
struct SampleApp: App {
    @WindowState(.custom) var isPresented = true

    var body: some Scene {
        WindowScene(isPresented: $isPresented, key: .custom) { payload in
            CustomWindow(content: { ContentView(name: payload?.name) })
        }
    }
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

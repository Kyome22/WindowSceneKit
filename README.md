# WindowSceneKit

Providing NSWindow via SwiftUI Scene.

## Requirements

- Development with Xcode 16.0+
- Written in Swift 6.0
- Compatible with macOS 14.0+

## Usage

Below is an example of displaying a custom `NSWindow`.

```swift
@main
struct SampleApp: App {
    @WindowState("SomeWindowKey") var isPresented: Bool = true

    var body: some Scene {
        WindowScene(isPresented: $isPresented, window: CustomWindow(content: {
            ContentView()
        }))
    }
}
```

```swift
final class CustomWindow: NSWindow {
    init<Content: View>(@ViewBuilder content: () -> Content) {
        super.init(
            contentRect: .zero,
            styleMask: [.closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        level = .popUpMenu
        collectionBehavior = [.canJoinAllSpaces]
        alphaValue = .zero
        contentView = NSHostingView(rootView: content())
    }

    override func orderFrontRegardless() {
        super.orderFrontRegardless()
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.2
            context.allowsImplicitAnimation = true
            animator().alphaValue = 1.0
        } completionHandler: {
            self.makeKey()
        }
    }

    override func close() {
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.2
            context.allowsImplicitAnimation = true
            animator().alphaValue = .zero
        } completionHandler: {
            super.close()
        }
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

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

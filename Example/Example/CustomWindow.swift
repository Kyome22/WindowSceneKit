import SwiftUI

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

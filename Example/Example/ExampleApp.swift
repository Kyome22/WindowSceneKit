import SwiftUI
import WindowSceneKit

struct CustomPayload: Sendable {
    let name: String
}

extension WindowSceneKey where Payload == CustomPayload {
    static var custom: Self { .init("CustomWindow") }
}

@main
struct ExampleApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @WindowState(.custom) var isPresented = false
    @State var name: String = ""

    var body: some Scene {
        WindowGroup {
            VStack {
                Toggle("Open Window", isOn: $isPresented)
                TextField("Name", text: $name)
                Button("Open Window with payload") {
                    WindowSceneMessenger.request(.open, for: .custom, payload: CustomPayload(name: name))
                }
            }
            .fixedSize()
            .padding()
        }
        .windowResizability(.contentSize)

        WindowScene(isPresented: $isPresented, key: .custom) { payload in
            CustomWindow {
                ContentView(name: payload?.name)
            }
        }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}

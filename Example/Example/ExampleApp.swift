import SwiftUI
import WindowSceneKit

@main
struct ExampleApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @WindowState("SomeWindowKey") var isPresented = false
    @State var name: String = ""

    var body: some Scene {
        WindowGroup {
            VStack {
                Toggle("Open Window", isOn: $isPresented)
                TextField("Name", text: $name)
                Button("Open Window with supplements") {
                    WindowSceneMessenger.request(
                        windowAction: .open,
                        windowKey: "SomeWindowKey",
                        supplements: ["name": name]
                    )
                }
            }
            .fixedSize()
            .padding()
        }
        .windowResizability(.contentSize)

        WindowScene(isPresented: $isPresented, window: { supplements in
            CustomWindow {
                ContentView(name: supplements["name"] as? String)
            }
        })
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}

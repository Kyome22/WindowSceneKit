import SwiftUI
import WindowSceneKit

struct ContentView: View {
    var name: String?

    var body: some View {
        VStack {
            if let name {
                Text("Hello, world! \(name)")
            }  else {
                Text("Hello, world!")
            }
        }
        .fixedSize()
        .padding()
    }
}

#Preview {
    ContentView(name: nil)
}

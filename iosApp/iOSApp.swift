import SwiftUI
import shared

@main
struct iOSApp: App {
  init() {
    DIManager.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}


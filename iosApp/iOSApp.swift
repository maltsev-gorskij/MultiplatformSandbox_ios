import SwiftUI
import shared

@main
struct iOSApp: App {
  init() {
    DIManager.configure()
    AppInitializer().doInit()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}


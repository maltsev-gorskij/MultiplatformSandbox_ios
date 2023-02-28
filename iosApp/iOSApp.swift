import SwiftUI
import shared
import FirebaseCore
import FirebaseCrashlytics

@main
struct iOSApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    DIManager.configure()
    AppInitializer().doInit()
    Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)

    return true
  }
}

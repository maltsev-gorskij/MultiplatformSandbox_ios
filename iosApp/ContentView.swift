import SwiftUI
import shared

struct ContentView: View {
  var body: some View {
    TabView {
      LaunchesView()
        .tabItem {
          Label("Launches", systemImage: "airplane")
        }
      FavoritesView()
        .tabItem {
          Label("Favorites", systemImage: "heart")
        }
      ProfileView()
        .tabItem {
          Label("Profile", systemImage: "person")
        }
    }.onAppear {
      do {
//        let profile = try DIManager.shared.profileInteractor.getProfile()
//        let pro
//        print("DEBUG: \(profile)")
        let string = try PrefsProvider().provideString()
        print("DEBUG: \(string)")
        let stringEncrypted = try PrefsProvider().provideEncryptedString()
        print("DEBUG: \(stringEncrypted)")
      } catch let error {
        print(error.localizedDescription)
      }
    }
  }
}

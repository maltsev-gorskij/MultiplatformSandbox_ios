import SwiftUI
import shared

struct ContentView: View {
  var body: some View {
    TabView {
      LaunchesView()
        .tabItem {
          Label(Strings.bottom_nav_launches.string, systemImage: "airplane")
        }
      FavoritesView()
        .tabItem {
          Label(Strings.bottom_nav_favourites.string, systemImage: "heart")
        }
      ProfileView()
        .tabItem {
          Label(Strings.bottom_nav_profile.string, systemImage: "person")
        }
    }
  }
}

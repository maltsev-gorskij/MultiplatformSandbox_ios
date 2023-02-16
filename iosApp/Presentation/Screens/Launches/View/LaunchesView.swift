//
//  LaunchesView.swift
//  iosApp
//
//  Created by Андрей Лапин on 20.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct LaunchesView: View {
  @StateObject private var viewModel: LaunchesViewModel = LaunchesViewModel(interactor: DIManager.shared.launcesInteractor)
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        ScrollView {
          LazyVStack(spacing: 10) {
            ForEach(viewModel.launches) { launch in
              NavigationLink(
                destination: LaunchDetailView(viewModel: .init(interactor: DIManager.shared.launcesInteractor, launchId: launch.id))
              ) {
                RocketLaunchRow(rocketLaunch: launch)
              }
              .buttonStyle(PlainButtonStyle())
            }
            if viewModel.showLoaderPagination {
              ProgressView()
                .onAppear {
                  viewModel.loadNextPage()
                }
            }
          }
        }
        .refreshable {
          viewModel.refreshPagination()
        }
        if let toast = viewModel.toast {
          ToastView(toast: toast)
            .padding(.bottom, 30)
        }
      }
      .navigationBarTitle(Strings.launches_header_text.string)
    }
  }
}

struct LaunchesView_Preview: PreviewProvider {
  static var previews: some View {
    LaunchesView()
  }
}

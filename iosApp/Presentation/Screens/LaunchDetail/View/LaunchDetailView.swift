//
//  LaunchDetailView.swift
//  iosApp
//
//  Created by Андрей Лапин on 30.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct LaunchDetailView: View {
  @StateObject var viewModel: LaunchDetailViewModel
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 0) {
        if let launch = viewModel.rocketLaunch {
          VStack(spacing: 20) {
            imagesCollection(launch: launch)
            textBlock("Start Date", text: launch.launchDateUTC)
            Text(launch.launchTextSuccess)
              .bold()
              .frame(maxWidth: .infinity, alignment: .leading)
            textBlock("Launch details", text: launch.details ?? "")
          }
        } else if let error = viewModel.error {
          Text(error)
        }
      }
      .padding(.horizontal, 30)
    }
    .navigationTitle(
      Text(viewModel.rocketLaunch?.missionName ?? "Rocket launch")
    )
    .navigationBarTitleDisplayMode(.inline)
  }

  @ViewBuilder
  private func imagesCollection(launch: RocketLaunch) -> some View {
    Group {
      if launch.flickrImagesUrls.isEmpty {
        AsyncImage(url: URL(string: launch.patchImageUrl ?? "")) { image in
          image
            .resizable()
            .scaledToFit()
        } placeholder: {
          ProgressView()
        }
      } else {
        TabView {
          ForEach(launch.flickrImagesUrls, id: \.self) { imageURL in
            AsyncImage(url: URL(string: imageURL)) { image in
              image
                .resizable()
                .scaledToFit()
            } placeholder: {
              ProgressView()
            }
          }
        }
        .tabViewStyle(PageTabViewStyle())
      }
    }
    .frame(height: 200)
  }

  @ViewBuilder
  private func textBlock(_ header: String, text: String) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(header)
        .bold()
      Text(text)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

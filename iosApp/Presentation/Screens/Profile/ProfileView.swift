//
//  ProfileView.swift
//  iosApp
//
//  Created by Андрей Лапин on 20.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @StateObject private var viewModel = ProfileViewModel(interactor: DIManager.shared.profileInteractor)

  var body: some View {
    VStack(spacing: 60) {
      VStack(spacing: 20) {
        TextField(Strings.profile_username_hint.string, text: $viewModel.userName)
        TextField(Strings.profile_text_hint.string, text: $viewModel.encryptedText)
      }
      Button(Strings.common_save.string) {
        viewModel.save()
      }
    }
    .padding(.horizontal, 40)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

//
//  ProfileViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 27.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

final class ProfileViewModel: ObservableObject {
  @Published var encryptedText: String = ""
  @Published var userName: String = ""

  private let interactor: ProfileInteractor

  init(interactor: ProfileInteractor) {
    self.interactor = interactor
    get()
  }

  func save() {
    let profile = Profile(
      userName: userName, encryptedText: encryptedText
    )
    do {
      try interactor.saveProfile(profile: profile)
    } catch let error {
      print(error.localizedDescription)
    }
  }

  func get() {
    do {
      let profile = try interactor.getProfile()
      encryptedText = profile.encryptedText
      userName = profile.userName
    } catch let error {
      print("Error: ", error.localizedDescription)
    }
  }
}

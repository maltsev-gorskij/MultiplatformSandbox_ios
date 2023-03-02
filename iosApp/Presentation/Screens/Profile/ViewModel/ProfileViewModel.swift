//
//  ProfileViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 27.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared
import sharedSwift

final class ProfileViewModel: ObservableObject {
  @Published var encryptedText: String = ""
  @Published var userName: String = ""
  @Published private(set) var errorMessage = ""

  private let interactor: ProfileInteractor
  // Commented Crashlytics example. Move it or remain here
//  private let crashlyticsInteractor: FirebaseIntegrationInteractor

  init(interactor: ProfileInteractor) {
    self.interactor = interactor
    // Commented Crashlytics example. Move it or remain here
//    self.crashlyticsInteractor = FirebaseIntegrationInteractor()
    get()
  }

  func save() {
    // Commented Crashlytics example. Move it or remain here
//    crashlyticsInteractor.firebaseCrashlyticsTest()
    
    let profile = Profile(
      userName: userName, encryptedText: encryptedText
    )

    interactor.saveProfile(profile: profile) { [weak self] sharedResult, _ in
      guard let self = self, let sharedResult = sharedResult else { return }
      let sharedResultKs = SharedResultKs(sharedResult)
      switch sharedResultKs {
      case .exception(let sharedResultException):
        self.errorMessage = sharedResultException.exception.message ?? ""
      case .success:
        break
      }
    }
  }

  func get() {
    interactor.getProfile { [weak self] sharedResult, _ in
      guard let self = self, let sharedResult = sharedResult else { return }
      let sharedResultKs = SharedResultKs(sharedResult)
      switch sharedResultKs {
      case .exception(let sharedResultException):
        self.errorMessage = sharedResultException.exception.message ?? ""
      case .success(let sharedResultSuccess):
        let profile = sharedResultSuccess.data
        self.encryptedText = profile.encryptedText
        self.userName = profile.userName
      }
    }
  }
}

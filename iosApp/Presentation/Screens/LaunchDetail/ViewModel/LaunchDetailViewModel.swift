//
//  LaunchDetailViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 30.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared
import sharedSwift

final class LaunchDetailViewModel: ObservableObject {
  @Published private(set) var rocketLaunch: RocketLaunch?
  @Published private(set) var error: String?
  
  private let interactor: LaunchesInteractor
  
  init(interactor: LaunchesInteractor, launchId: String) {
    self.interactor = interactor
    getLaunch(id: launchId)
  }
  
  private func getLaunch(id: String) {
    interactor.getLaunchById(launchId: id) { [weak self] sharedResult, _ in
      guard let self = self, let sharedResult = sharedResult else { return }
      let sharedResultKs = SharedResultKs(sharedResult)
      DispatchQueue.main.async {
        switch sharedResultKs {
        case .exception(let sharedResultException):
          guard let dbException = sharedResultException.exception as? DatabaseExceptions else { return }
          let errorMessage = DatabaseExceptionsKs(dbException).sealed.errorMessage
          print("DEBUG: error - \(errorMessage)")
          self.error = errorMessage
        case .success(let sharedResultSuccess):
          self.rocketLaunch = sharedResultSuccess.data
        }
      }
    }
  }
}

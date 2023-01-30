//
//  LaunchDetailViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 30.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

final class LaunchDetailViewModel: ObservableObject {
  @Published private(set) var rocketLaunch: RocketLaunch?
  @Published private(set) var error: String?

  private let interactor: LaunchesInteractor

  init(interactor: LaunchesInteractor, launchId: String) {
    self.interactor = interactor
    getLaunch(id: launchId)
  }

  private func getLaunch(id: String) {
    interactor.getLaunchById(launchId: id) { [weak self] rocketLaunch, error in
      guard let self = self else { return }
      if let error = error {
        print("DEBUG: get launch by id: \(id) with error: \(error.localizedDescription)")
        DispatchQueue.main.async {
          self.error = error.localizedDescription
        }
        return
      }
      guard let rocketLaunch = rocketLaunch else { return }
      DispatchQueue.main.async {
        self.rocketLaunch = rocketLaunch
      }
    }
  }
}

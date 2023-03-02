//
//  LaunchDetailViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 30.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared
import sharedSwift
import KMPNativeCoroutinesCombine
import Combine

final class LaunchDetailViewModel: ObservableObject {
  @Published private(set) var rocketLaunch: RocketLaunch?
  @Published private(set) var error: String?

  private let interactor: LaunchesInteractor

  private var cancels = Set<AnyCancellable>()
  
  init(interactor: LaunchesInteractor, launchId: String) {
    self.interactor = interactor
    getLaunch(id: launchId)
  }
  
  private func getLaunch(id: String) {
    createPublisher(for: interactor.getLaunchByIdNative(launchId: id))
      .receive(on: RunLoop.main)
      .sink { _ in
      } receiveValue: { [weak self] sharedResult in
        guard let self = self else { return }
        let sharedResultKs = SharedResultKs(sharedResult)
        switch sharedResultKs {
        case .exception(let sharedResultException):
          guard let dbException = sharedResultException.exception as? DatabaseExceptions else { return }
          let errorMessage = DatabaseExceptionsKs(dbException).sealed.errorMessage
          self.error = errorMessage
        case .success(let sharedResultSuccess):
          self.rocketLaunch = sharedResultSuccess.data
        }
      }
      .store(in: &cancels)
  }
}

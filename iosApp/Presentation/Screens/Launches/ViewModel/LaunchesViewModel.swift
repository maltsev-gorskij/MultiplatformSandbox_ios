//
//  LaunchesViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 20.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared
import sharedSwift
import Combine
import KMPNativeCoroutinesCombine

final class LaunchesViewModel: ObservableObject {
  private let interactor: LaunchesInteractor

  @Published private(set) var launches: [RocketLaunch] = []
  @Published private(set) var showLoaderPagination = false
  @Published private(set) var toast: Toast?

  private var timer: Timer?
  private var paginationProvider: PaginationProvider<RocketLaunch>

  private var cancels = Set<AnyCancellable>()

  init(interactor: LaunchesInteractor) {
    self.interactor = interactor
    self.paginationProvider = interactor.getPaginationProvider()
    listenerPaginationState()
  }

  func loadNextPage() {
    paginationProvider.loadNextPage()
  }

  func refreshPagination() {
    paginationProvider.refreshPagination()
  }

  private func listenerPaginationState() {
    createPublisher(for: paginationProvider.paginationStateNative)
      .receive(on: RunLoop.main)
      .sink { _ in
      } receiveValue: { [weak self] paginationState in
        guard let self = self else { return }
        let stateKs = PaginationStateKs(paginationState)
        switch stateKs {
        case .failed:
          self.shownToast(toast: .failed)
          self.showLoaderPagination = false
        case .loading:
          self.showLoaderPagination = false
        case .success(let paginationStateSuccess):
          let rocketLaunches = paginationStateSuccess.data.compactMap { $0 as? RocketLaunch }
          self.launches = rocketLaunches
          self.showLoaderPagination = true
          if paginationStateSuccess.isRefreshed {
            self.shownToast(toast: .success)
          }
        }
      }
      .store(in: &cancels)

  }

  private func shownToast(toast: Toast) {
    DispatchQueue.main.async {
      self.toast = toast
    }
    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
      guard let self = self else { return }
      self.toast = nil
    }
  }
}

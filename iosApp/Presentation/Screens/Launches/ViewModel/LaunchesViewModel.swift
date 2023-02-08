//
//  LaunchesViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 20.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared
import sharedSwift

final class LaunchesViewModel: ObservableObject {
  private let interactor: LaunchesInteractor

  @Published private(set) var launches: [RocketLaunch] = []
  @Published private(set) var showLoaderPagination = false
  @Published private(set) var toast: Toast?

  private var timer: Timer?
  private var paginationState: PaginationState?

  init(interactor: LaunchesInteractor) {
    self.interactor = interactor
    initialObservers()
  }

  func loadNextPage() {
    interactor.loadNextPage { _ in }
  }

  func refreshPagination() {
    interactor.refreshPagination { _ in }
  }

  private func initialObservers() {
    interactor.initializePagination { [weak self] paginationState, error in
      guard let self = self else { return }
      if let error = error {
        assertionFailure("DEBUG: failed get paginationState\(error.localizedDescription)")
        return
      }
      self.paginationState = paginationState
      self.addObserversStates()
    }
  }
  
  private func addObserversStates() {
    paginationState?.resourceState.addObserver { [weak self] resourceState in
      guard let self = self, let resourceState = resourceState else { return }
      let stateKs = ResourceStateKs(resourceState)
      self.updateResourceState(stateKs)
    }
    paginationState?.nextPageLoadingState.addObserver { [weak self] pageLoadingState in
      guard let self = self, let pageLoadingState = pageLoadingState else { return }
      let stateKs = ResourceStateKs(pageLoadingState)
      self.updatePageLoadingState(stateKs)
    }
  }

  private func updateResourceState(_ resourceState: ResourceStateKs<NSArray, KotlinThrowable>) {
    DispatchQueue.main.async {
      switch resourceState {
      case .success:
        let launchesString = resourceState
          .success({ $0! }, or: [])
        let launches = launchesString.compactMap { $0 as? RocketLaunch }
        self.launches = launches
        self.shownToast(toast: .success)
        self.showLoaderPagination = true
      default:
        break
      }
    }
  }

  private func updatePageLoadingState(_ pageLoadingState: ResourceStateKs<NSArray, KotlinThrowable>) {
    DispatchQueue.main.async {
      switch pageLoadingState {
      case .failed(let resourceStateFailed):
        print("DEBUG: failed loading next page - \(resourceStateFailed.description())")
        self.shownToast(toast: .success)
        self.showLoaderPagination = false
      default: break
      }
    }
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

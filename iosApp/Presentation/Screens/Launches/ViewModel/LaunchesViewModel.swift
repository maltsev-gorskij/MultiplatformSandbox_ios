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
  private var paginationState: LiveData<ResourceState<NSArray, KotlinThrowable>>?

  init(interactor: LaunchesInteractor) {
    self.interactor = interactor
    initialObservers()
  }

  func loadNextPage() {
    do {
      try interactor.loadNextPage()
    } catch let error {
      print("DEBUG: loadNextPage - \(error.localizedDescription)")
    }
  }

  func refreshPagination() {
    do {
      try interactor.refreshPagination()
    } catch let error {
      print("DEBUG: refreshPagination - \(error.localizedDescription)")
    }
  }

  private func initialObservers() {
    do {
      self.paginationState = try interactor.initializePagination()
    } catch let error {
      assertionFailure("DEBUG: error with initializePagination from interactor: \(error.localizedDescription)")
      return
    }
    paginationState?.addObserver { [weak self] resourceState in
      guard let self = self, let resourceState = resourceState else { return }
      let stateKs = ResourceStateKs(resourceState)
      self.updateUIState(stateKs)
    }
  }

  private func updateUIState(_ resourceState: ResourceStateKs<NSArray, KotlinThrowable>) {
    switch resourceState {
    case .success:
      let launchesString = resourceState
        .success({ $0! }, or: [])
      let launches = launchesString.compactMap { $0 as? RocketLaunch }
      self.launches = launches
      self.shownToast(toast: .success)
      self.showLoaderPagination = true
    case .failed:
      self.shownToast(toast: .failed)
      self.showLoaderPagination = false
    default:
      break
    }
  }

  private func shownToast(toast: Toast) {
    self.toast = toast
    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
      guard let self = self else { return }
      self.toast = nil
    }
  }
}

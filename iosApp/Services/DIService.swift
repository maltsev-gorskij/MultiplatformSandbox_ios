//
//  DIService.swift
//  iosApp
//
//  Created by Андрей Лапин on 27.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

final class DIManager {

  static func configure() {
    KoinInitializerKt.initializeKoin()
  }

  static let shared = DIManager()

  init() {
  }

  let launcesInteractor = LaunchesInteractor()
  let profileInteractor = ProfileInteractor()
}

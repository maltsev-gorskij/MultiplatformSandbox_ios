//
//  Resourse+string.swift
//  iosApp
//
//  Created by Андрей Лапин on 01.02.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

extension StringResource {
  var string: String { self.desc().localized() }
}

extension ResourceFormattedStringDesc {
  var string: String { self.localized() }
}

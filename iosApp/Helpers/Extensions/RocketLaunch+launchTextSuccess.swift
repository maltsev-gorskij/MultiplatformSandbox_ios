//
//  RocketLaunch+launchTextSuccess.swift
//  iosApp
//
//  Created by Андрей Лапин on 30.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

extension RocketLaunch {
  var launchTextSuccess: String {
   if let isSuccess = self.launchSuccess {
     return isSuccess.boolValue ? Strings.launch_card_successful.string : Strings.launch_card_unsuccessful.string
   } else {
     return "No data"
   }
 }
}

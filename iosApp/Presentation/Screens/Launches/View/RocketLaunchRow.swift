//
//  RocketLaunchRow.swift
//  iosApp
//
//  Created by Dmitry Maltsev-Gorsky on 12.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct RocketLaunchRow: View {
  var rocketLaunch: RocketLaunch
  
  var body: some View {
    HStack() {
      VStack(alignment: .leading, spacing: 10.0) {
        Text(Strings.launch_card_name.format(args_: [rocketLaunch.missionName]).string)
        Text(rocketLaunch.launchTextSuccess)
          .foregroundColor(launchColor)
        Text(Strings.launch_card_year.format(args_: [rocketLaunch.launchYear]).string)
        Text(Strings.launch_card_details.format(args_: [rocketLaunch.details ?? ""]).string)
      }
      Spacer()
    }
  }
}

extension RocketLaunchRow {
  private var launchColor: Color {
    if let isSuccess = rocketLaunch.launchSuccess {
      return isSuccess.boolValue ? Color.green : Color.red
    } else {
      return Color.gray
    }
  }
}

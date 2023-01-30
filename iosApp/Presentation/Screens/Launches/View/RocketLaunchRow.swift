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
        Text("Launch name: \(rocketLaunch.missionName)")
        Text(rocketLaunch.launchTextSuccess).foregroundColor(launchColor)
        Text("Launch year: \(String(rocketLaunch.launchYear))")
        Text("Launch details: \(rocketLaunch.details ?? "")")
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

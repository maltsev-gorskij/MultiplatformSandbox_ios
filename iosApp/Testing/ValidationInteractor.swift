//
//  ValidationInteractor.swift
//  iosApp
//
//  Created by Андрей Лапин on 14.02.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared
import sharedSwift
import KMPNativeCoroutinesCombine

class Testing {
  let validation = ValidationInteractor()

  func testing() {
    let publisher = createPublisher(for: validation.getSuspendNetworkSuccessNative())
    
    let cancellable = publisher.sink { completion in
      print("Received completion: \(completion)")
    } receiveValue: { value in
      SharedLogger().logDebug(message: "Received value: \(value)", throwable: nil, tag: "SomeTag")
      print("Received value: \(value)")
    }
  
//    cancellable.cancel()
    
//    validation.getSuspendNetworkSuccess { sharedResult, _ in
//      guard let sharedResult = sharedResult else { return }
//      let sharedKs = SharedResultKs(sharedResult)
//      switch sharedKs {
//      case .success(let success):
//        print("DEBUG: \(success)")
//      case .exception(let failure):
//        print("DEBUG: error \(failure.exception)")
//      }
//    }
//    validation.getSuspendNetworkException { sharedResult, _ in
//      guard let sharedResult = sharedResult else { return }
//      let sharedKs = SharedResultKs(sharedResult)
//      switch sharedKs {
//      case .success:
//        break
//      case .exception(let failure):
//        let exception = KtorExceptionsKs(failure.exception as! KtorExceptions)
//        print("DEBUG: error -", exception.sealed.errorCode)
//      }
//    }
//
//    validation.getSuspendSuccess { sharedResult, _ in
//      guard let sharedResult = sharedResult else { return }
//      let sharedResultKs = SharedResultKs(sharedResult)
//      sharedResult.onSuccess { result in
//        guard let str = result as? String else { return }
//      }
//    }
//
//    validation.getSuspendError { sharedResult, _ in
//      guard let sharedResult = sharedResult else { return }
//      let sharedResultKs = SharedResultKs(sharedResult)
//      switch sharedResultKs {
//      case .exception(let sharedResultException):
//        print("DEBUG: with error -", sharedResultException.exception.message ?? "")
//      case .success:
//        break
//      }
//    }
//
//    validation.getSuspendDatabaseEntries { sharedResult, _ in
//      guard let sharedResult = sharedResult else { return }
//      let sharedKs = SharedResultKs(sharedResult)
//      switch sharedKs {
//      case .exception(let sharedResultException):
//        let exception = DatabaseExceptionsKs(sharedResultException.exception as! DatabaseExceptions)
//        print("DEBUG: with error -", exception.sealed)
//      case .success:
//        break
//      }
//    }
  }
}

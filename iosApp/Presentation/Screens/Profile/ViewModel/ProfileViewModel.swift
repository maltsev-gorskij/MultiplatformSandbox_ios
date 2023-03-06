//
//  ProfileViewModel.swift
//  iosApp
//
//  Created by Андрей Лапин on 27.01.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared
import sharedSwift
//import shared_firebase

final class ProfileViewModel: ObservableObject {
  @Published var encryptedText: String = ""
  @Published var userName: String = ""
  @Published private(set) var errorMessage = ""
  
  private let interactor: ProfileInteractor
  // Commented example of Firestore usage. Move somethere or remain here
  //  private let firestore: FirestoreClient
  
  init(interactor: ProfileInteractor) {
    self.interactor = interactor
    // Commented example of Firestore usage. Move somethere or remain here
    //    self.firestore = FirestoreClient()
    
    // Commented Crashlytics example. Move it or remain here
    //  private let crashlyticsInteractor: FirebaseIntegrationInteractor

      // Commented Crashlytics example. Move it or remain here
      //    self.crashlyticsInteractor = FirebaseIntegrationInteractor()
      
      get()
    }
    
    func save() {
      // Commented example of Firestore usage. Move somethere or remain here
      //    self.firestore.addUser(name: "Vasya", completionHandler: { error in })
      //    self.firestore.getFirstUser { error in }
      
      // Commented Crashlytics example. Move it or remain here
      //    crashlyticsInteractor.firebaseCrashlyticsTest()
      
      let profile = Profile(
        userName: userName, encryptedText: encryptedText
      )
      
      interactor.saveProfile(profile: profile) { [weak self] sharedResult, _ in
        guard let self = self, let sharedResult = sharedResult else { return }
        let sharedResultKs = SharedResultKs(sharedResult)
        switch sharedResultKs {
        case .exception(let sharedResultException):
          self.errorMessage = sharedResultException.exception.message ?? ""
        case .success:
          break
        }
      }
    }
    
    func get() {
      interactor.getProfile { [weak self] sharedResult, _ in
        guard let self = self, let sharedResult = sharedResult else { return }
        let sharedResultKs = SharedResultKs(sharedResult)
        switch sharedResultKs {
        case .exception(let sharedResultException):
          self.errorMessage = sharedResultException.exception.message ?? ""
        case .success(let sharedResultSuccess):
          let profile = sharedResultSuccess.data
          self.encryptedText = profile.encryptedText
          self.userName = profile.userName
        }
      }
    }
  }


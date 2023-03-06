# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'iosApp' do
  use_frameworks!

  # KMM library
  pod 'sharedSwift', :path => 'MultiplatformSandbox_kmm/shared'
  pod 'shared', :path => 'MultiplatformSandbox_kmm/shared'
  pod 'shared_firebase', :path => 'MultiplatformSandbox_kmm/shared_firebase'

  # Kotlin to Swift suspend functions interop
  pod 'KMPNativeCoroutinesCombine', '0.13.3'

  # Firebase
  pod 'FirebaseCore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
  pod 'FirebaseCrashlytics', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
  pod 'FirebaseAnalytics', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
  pod 'FirebaseFirestore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
  pod 'FirebaseDatabase', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
end

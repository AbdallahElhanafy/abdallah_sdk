import Flutter
import UIKit
import FBSDKCoreKit

public class SwiftAbdallahSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
            let channel = FlutterMethodChannel(name: "abdallah_sdk", binaryMessenger: registrar.messenger())
            let instance = SwiftAbdallahSdkPlugin()

            // Required for FB SDK 9.0, as it does not initialize the SDK automatically any more.
            // See: https://developers.facebook.com/blog/post/2021/01/19/introducing-facebook-platform-sdk-version-9/
            // "Removal of Auto Initialization of SDK" section
            ApplicationDelegate.shared.initializeSDK()

            registrar.addMethodCallDelegate(instance, channel: channel)
            registrar.addApplicationDelegate(instance)
        }
        
        public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
            Settings.shared.isAdvertiserTrackingEnabled = false
            let launchOptionsForFacebook = launchOptions as? [UIApplication.LaunchOptionsKey: Any]
            ApplicationDelegate.shared.application(
                application,
                didFinishLaunchingWithOptions:
                    launchOptionsForFacebook
            )
            return true
        }
        
        public func applicationDidBecomeActive(_ application: UIApplication) {
            AbdallahSdkMethods.activateApp()
        }
        
        public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }

        public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            switch call.method {
            case "activateApp":
                AbdallahSdkMethods.activateApp()
                break
            case "clearUserData":
                AbdallahSdkMethods.clearUserData(result: result)
                break
            case "setUserData":
                AbdallahSdkMethods.setUserData(call, result: result)
                break
            case "clearUserID":
                AbdallahSdkMethods.clearUserID(result: result)
                break
            case "flush":
                AbdallahSdkMethods.flush(result: result)
                break
            case "getApplicationId":
                AbdallahSdkMethods.getApplicationId(result: result)
                break
            case "logEvent":
                AbdallahSdkMethods.logEvent(call, result: result)
                break
            case "logPushNotificationOpen":
                AbdallahSdkMethods.pushNotificationOpen(call, result: result)
                break
            case "setUserID":
               AbdallahSdkMethods.setUserId(call, result: result)
                break
            case "setAutoLogAppEventsEnabled":
                AbdallahSdkMethods.setAutoLogAppEventsEnabled(call, result: result)
                break
            case "setDataProcessingOptions":
                AbdallahSdkMethods.setDataProcessingOptions(call, result: result)
                break
            case "logPurchase":
                AbdallahSdkMethods.purchased(call, result: result)
                break
            case "getAnonymousId":
                AbdallahSdkMethods.getAnonymousId(result: result)
                break
            case "setAdvertiserTracking":
                AbdallahSdkMethods.setAdvertiserTracking(call, result: result)
                break
            default:
                result(FlutterMethodNotImplemented)
            }
        }
}

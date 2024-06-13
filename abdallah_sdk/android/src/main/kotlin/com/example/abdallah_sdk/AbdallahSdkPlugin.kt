package com.example.abdallah_sdk

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AbdallahSdkPlugin */
class AbdallahSdkPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var appEventsLogger: AppEventsLogger
  private lateinit var anonymousId: String
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "abdallah_sdk")
    channel.setMethodCallHandler(this)
    appEventsLogger = AppEventsLogger.newLogger(flutterPluginBinding.applicationContext)
    anonymousId =
      AppEventsLogger.getAnonymousAppDeviceGUID(flutterPluginBinding.applicationContext)

    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
   override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "activateApp" -> AbdallahSdkMethods.activateApp(appEventsLogger, result)
      "clearUserData" -> AbdallahSdkMethods.clearUserData(result)
      "setUserData" -> AbdallahSdkMethods.setUserData(call, result)
      "clearUserID" -> AbdallahSdkMethods.clearUserId(result)
      "flush" -> AbdallahSdkMethods.flush(appEventsLogger, result)
      "getApplicationId" -> AbdallahSdkMethods.getApplicationId(appEventsLogger, result)
      "logEvent" -> AbdallahSdkMethods.logEvent(appEventsLogger, call, result)
      "logPushNotificationOpen" -> AbdallahSdkMethods.pushNotificationOpen(
        appEventsLogger,
        call,
        result
      )
      "setUserID" -> AbdallahSdkMethods.setUserId(call, result)
      "setAutoLogAppEventsEnabled" -> AbdallahSdkMethods.setAutoLogAppEventsEnabled(
        call,
        result
      )
      "setDataProcessingOptions" -> AbdallahSdkMethods.setDataProcessingOptions(call, result)
      "getAnonymousId" -> AbdallahSdkMethods.getAnonymousId(
        anonymousId,
        result
      )
      "logPurchase" -> AbdallahSdkMethods.purchased(appEventsLogger, call, result)
      "setAdvertiserTracking" -> AbdallahSdkMethods.setAdvertiserTracking(result)
      else -> result.notImplemented()
    }
  }
}

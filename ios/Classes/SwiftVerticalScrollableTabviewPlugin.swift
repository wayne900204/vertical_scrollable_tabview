import Flutter
import UIKit

public class SwiftVerticalScrollableTabviewPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "vertical_scrollable_tabview", binaryMessenger: registrar.messenger())
    let instance = SwiftVerticalScrollableTabviewPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}

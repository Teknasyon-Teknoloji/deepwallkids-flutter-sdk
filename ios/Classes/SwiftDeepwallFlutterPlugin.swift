import Flutter
import UIKit
import DeepWallKids
import Foundation

public class SwiftDeepWallKidsFlutterPlugin: NSObject, FlutterPlugin, DeepWallKidsNotifierDelegate {

    let eventStreamHandler = DeepWallKidsStreamHandler()
    static var viewController = UIViewController();

    override init(){
    }
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "deepwallkids_flutter_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "deepwallkids_plugin_stream", binaryMessenger: registrar.messenger())
        let instance = SwiftDeepWallKidsFlutterPlugin()
        viewController =
                    (UIApplication.shared.delegate?.window??.rootViewController)!;
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance.eventStreamHandler)
    }

    class DeepWallKidsStreamHandler : NSObject, FlutterStreamHandler {
        var eventSink: FlutterEventSink?
        override init(){
        }

        public func onListen(withArguments arguments: Any?,eventSink events: @escaping FlutterEventSink) -> FlutterError? {
            self.eventSink = events
            return nil
        }

        func sendData(state: Dictionary<String,Any>) {
            print(state)
            self.eventSink?(state)
        }

        public func onCancel(withArguments arguments: Any?) -> FlutterError? {
            return nil
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call.method)
        if(call.method == "initialize"){
            //observeDeepWallKidsEvents()
            DeepWallKids.shared.observeEvents(for: self)
            guard let args = call.arguments else {
                return result("Could not recognize flutter arguments in method: (initialize)")
            }
            if let myArgs = args as? [String: Any]{
                let apiKey = myArgs["apiKey"] as! String
                let environment = myArgs["environment"] as! Int
                var deepWallKidsEnvironment : DeepWallKidsEnvironment;
                if (environment == 1){
                    deepWallKidsEnvironment = .sandbox
                }
                else{
                    deepWallKidsEnvironment = .production
                }
                DeepWallKids.initialize(apiKey: apiKey, environment: deepWallKidsEnvironment)
            } else {
                result(FlutterError(code: "-1", message: "iOS could not extract " +
                    "flutter arguments in method: (initialize)", details: nil))
            }

        }
        else if(call.method == "setUserProperties"){
            guard let args = call.arguments else {
                return result("Could not recognize flutter arguments in method: (setUserProperties)")
            }
            if let myArgs = args as? [String: Any]{
                let uuid = myArgs["uuid"] as! String
                let country = myArgs["country"] as! String
                let language = myArgs["language"] as! String
                let environmentStyle = myArgs["environmentStyle"] as! Int

                let theme: DeepWallKidsEnvironmentStyle
                if environmentStyle == -7 {
                    theme = .automatic
                } else {
                    theme = (environmentStyle == 0) ? .light : .dark
                }
                let properties = DeepWallKidsUserProperties(
                    uuid: uuid,
                    country: country,
                    language: language,
                    environmentStyle: theme)

                DeepWallKids.shared.setUserProperties(properties)
            } else {
                result(FlutterError(code: "-1", message: "iOS could not extract " +
                    "flutter arguments in method: (initialize)", details: nil))
            }
        }
        else if (call.method == "requestPaywall"){
            guard let args = call.arguments else {
                return result("Could not recognize flutter arguments in method: (requestPaywall)")
            }
            if let myArgs = args as? [String: Any]{
                let actionKey = myArgs["actionKey"] as! String
                if let extraData = myArgs["extraData"] as? Dictionary<String,Any> {

                    /*var bundle = Bundle()
                    if (extraData != nil) {
                        for key in extraData.keys {
                            if (extraData[key] is Bool) {
                                bundle.putBoolean(key, extraData[key] as Bool)
                            } else if (extraData[key] is Int) {
                                bundle.putInt(key, extraData[key] as Int)
                            } else if (extraData[key] is Double) {
                                bundle.putDouble(key, extraData[key] as Double)
                            } else if (extraData[key] is String) {
                                bundle.putString(key, extraData[key] as String)
                            }
                            else{
                                bundle.putString(key, extraData[key] as String)
                            }
                        }
                    }*/
                    DeepWallKids.shared.requestPaywall(action: actionKey, in: SwiftDeepWallKidsFlutterPlugin.viewController, extraData: extraData)
                }
                else{
                    DeepWallKids.shared.requestPaywall(action: actionKey, in: SwiftDeepWallKidsFlutterPlugin.viewController, extraData: [:])
                }

            } else {
                result(FlutterError(code: "-1", message: "iOS could not extract " +
                    "flutter arguments in method: (requestPaywall)", details: nil))
            }

        }
        else if(call.method == "updateUserProperties"){
            guard let args = call.arguments else {
                return result("Could not recognize flutter arguments in method: (updateUserProperties)")
            }
            if let myArgs = args as? [String: Any]{
                let country = myArgs["country"] as! String
                let language = myArgs["language"] as! String
                let environmentStyle = myArgs["environmentStyle"] as! Int
                let theme: DeepWallKidsEnvironmentStyle
                if environmentStyle == -7 {
                    theme = .automatic
                } else {
                    theme = (environmentStyle == 0) ? .light : .dark
                }
                let phoneNumber = myArgs["phoneNumber"] as? String
                DeepWallKids.shared.updateUserProperties(
                    country:country,
                    language:language,
                    environmentStyle:theme
                )

            } else {
                result(FlutterError(code: "-1", message: "iOS could not extract " +
                    "flutter arguments in method: (updateUserProperties)", details: nil))
            }

        }
        else if (call.method == "closePaywall"){
            DeepWallKids.shared.closePaywall()
        }
         else if (call.method == "sendExtraDataToPaywall"){
            guard let args = call.arguments else {
                return result("Could not recognize flutter arguments in method: (sendExtraDataToPaywall)")
            }
            if let myArgs = args as? [String: Any]{
                if let extraData = myArgs["extraData"] as? Dictionary<String,Any> {
                   DeepWallKids.shared.sendExtraData(toPaywall: extraData)
                }
                else{
                    return result("Could not recognize flutter arguments in method: (sendExtraDataToPaywall)")
                }
            } else {
                result(FlutterError(code: "-1", message: "iOS could not extract " +
                    "flutter arguments in method: (sendExtraDataToPaywall)", details: nil))
            }
        }
        else if(call.method == "hidePaywallLoadingIndicator"){
            DeepWallKids.shared.hidePaywallLoadingIndicator()
        }
        else if(call.method == "validateReceipt"){
            guard let args = call.arguments else {
                return result("Could not recognize flutter arguments in method: (validateReceipt)")
            }
            if let myArgs = args as? [String: Any]{
                var validationType = myArgs["validationType"] as? Int
                var validation: PloutosValidationType
                switch (validationType) {
                    case 1:
                        validation = .purchase
                    case 2:
                        validation = .restore
                    case 3:
                        validation = .automatic
                    default:
                        validation = .purchase
                }
                DeepWallKids.shared.validateReceipt(for: validation)
            } else {
                result(FlutterError(code: "-1", message: "iOS could not extract " +
                    "flutter arguments in method: (validateReceipt)", details: nil))
            }

        }
        else if(call.method == "consumeProduct"){
            //TODO call DeepWall's consumeProduct method
        }
        else if(call.method == "setProductUpgradePolicy"){
            //TODO call DeepWall's setProductUpgradePolicy method
        }
        else if(call.method == "updateProductUpgradePolicy"){
            //TODO call DeepWall's updateProductUpgradePolicy method
        }
        else {
            result(FlutterMethodNotImplemented)
        }
    }

    public func deepWallKidsPaywallRequested() -> Void {
        print("event:deepWallKidsPaywallRequested");
        var mapData = [String: Any]()
        mapData["data"] =  ""
        mapData["event"] = "deepWallKidsPaywallRequested"
        self.eventStreamHandler.sendData(state: mapData)
    }

    public func deepWallKidsPaywallResponseReceived() -> Void {
        print("event:deepWallKidsPaywallResponseReceived");
        var mapData = [String: Any]()
        mapData["data"] =  ""
        mapData["event"] = "deepWallKidsPaywallResponseReceived"
        self.eventStreamHandler.sendData(state: mapData)
    }

    public func deepWallKidsPaywallOpened(_ model: DeepWallKidsPaywallOpenedInfoModel) -> Void {
        print("event:deepWallKidsPaywallOpened");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["pageId"] = model.pageId
        mapData["data"] = modelMap
        mapData["event"] =  "deepWallKidsPaywallOpened"
        self.eventStreamHandler.sendData(state: mapData)
    }

    public func deepWallKidsPaywallNotOpened(_ model: DeepWallKidsPaywallNotOpenedInfoModel) -> Void {
        print("event:deepWallKidsPaywallNotOpened");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["pageId"] = model.pageId
        modelMap["reason"] = model.reason
        modelMap["errorCode"] = model.errorCode
        mapData["data"] =  modelMap
        mapData["event"] =  "deepWallKidsPaywallNotOpened"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallClosed(_ model: DeepWallKidsPaywallClosedInfoModel) -> Void {
        print("event:deepWallKidsPaywallClosed");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["pageId"] = model.pageId
        mapData["data"] =  modelMap
        mapData["event"] =  "deepWallKidsPaywallClosed"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallActionShowDisabled(_ model: DeepWallKidsPaywallActionShowDisabledInfoModel) -> Void {
        print("event:deepWallKidsPaywallActionShowDisabled");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["pageId"] = model.pageId
        mapData["data"] =  modelMap
        mapData["event"] =  "deepWallKidsPaywallActionShowDisabled"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallResponseFailure(_ model: DeepWallKidsPaywallResponseFailedModel) -> Void {
        print("event:deepWallKidsPaywallResponseFailure");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["errorCode"] = model.errorCode
        modelMap["reason"] = model.reason
        mapData["data"] =  modelMap
        mapData["event"] =  "deepWallKidsPaywallResponseFailure"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallPurchasingProduct(_ model: DeepWallKidsPaywallPurchasingProduct) -> Void {
        print("event:deepWallKidsPaywallPurchasingProduct");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["productCode"] = model.productCode
        mapData["data"] =  modelMap
        mapData["event"] =  "deepWallKidsPaywallPurchasingProduct"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallPurchaseSuccess(_ model:  DeepWallKidsValidateReceiptResult) -> Void {
        print("event:deepWallKidsPaywallPurchaseSuccess");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["type"] = model.type.rawValue
        modelMap["result"] = model.result?.toDictionary() as? [String: Any];
        mapData["data"] =  modelMap
        mapData["event"] =  "deepWallKidsPaywallPurchaseSuccess"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallPurchaseFailed(_ model: DeepWallKidsPurchaseFailedModel) -> Void {
        print("event:deepWallKidsPaywallPurchaseFailed");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["productCode"] = model.productCode
        modelMap["reason"] = model.reason
        modelMap["errorCode"] = model.errorCode
        modelMap["isPaymentCancelled"] = model.isPaymentCancelled
        mapData["data"] =  modelMap
        mapData["event"] =  "deepWallKidsPaywallPurchaseFailed"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallRestoreSuccess() -> Void {
        print("event:deepWallKidsPaywallRestoreSuccess");
        var map = [String: Any]()
        map["data"] =  ""
        map["event"] = "deepWallKidsPaywallRestoreSuccess"
        self.eventStreamHandler.sendData(state: map)
    }
    public func deepWallKidsPaywallRestoreFailed(_ model: DeepWallKidsRestoreFailedModel) -> Void {
        print("event:deepWallKidsPaywallRestoreFailed");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["reason"] = model.reason.rawValue
        modelMap["errorCode"] = model.errorCode
        modelMap["errorText"] = model.errorText
        modelMap["isPaymentCancelled"] = model.isPaymentCancelled
        mapData["data"] =  modelMap
        mapData["event"] = "deepWallKidsPaywallRestoreFailed"
        self.eventStreamHandler.sendData(state: mapData)
    }
    public func deepWallKidsPaywallExtraDataReceived(_ model: [AnyHashable : Any]) -> Void {
        print("event:deepWallKidsPaywallExtraDataReceived");
        var mapData = [String: Any]()
        var modelMap = [String: Any]()
        modelMap["extraData"] = model as? [String: Any]
        mapData["data"] =  modelMap
        mapData["event"] = "deepWallKidsPaywallExtraDataReceived"
        self.eventStreamHandler.sendData(state: mapData)
    }

    private func convertJson(data: Data?) -> [String: Any]? {
        do {
            //let data = try JSONSerialization.data(withJSONObject: model, options: .prettyPrinted)

            let jsonData = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]
            return jsonData
        } catch {
            assertionFailure("JSON data creation failed with error: \(error).")
            return nil
        }
    }
}

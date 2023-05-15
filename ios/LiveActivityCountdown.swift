import LiveActivityCountdownView
import ActivityKit
import BackgroundTasks

@objc(LiveActivityCountdown)
public class LiveActivityCountdown: NSObject {
    override public init() {}
    
    @objc(createLiveActivity:withResolver:withRejecter:)
    func createLiveActivity(config: Dictionary<String, Any>, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) -> Void {
        if #available(iOS 16.1, *) {
            do {
                let secondsUntilEnd = config["secondsUntilEnd"] as! Double
                let liveActivityCountdownWidgetExtensionAttributes = LiveActivityCountdownWidgetExtensionAttributes(
                    title: config["title"] as! String,
                    timerTitle: config["timerTitle"] as! String,
                    buttonTitle: config["buttonTitle"] as! String,
                    secondsUntilEnd: config["secondsUntilEnd"] as! Double,
                    timerColor: config["timerColor"] as? String,
                    imageName: config["imageName"] as? String
                )
                let remainingHours = Int(secondsUntilEnd / 60 / 60)
                let newActivity = try Activity.request(attributes: liveActivityCountdownWidgetExtensionAttributes, contentState: LiveActivityCountdownWidgetExtensionAttributes.ContentState())
                resolve(newActivity.id)
            } catch {
                reject("CREATE_LIVE_ACTIVITY_FAILED", error.localizedDescription, error)
            }
        } else {
            resolve(nil)
        }
    }
    
    // TODO: add final content if dynamic state is added to the package
    // TODO: add dismissal policy
    @objc(endLiveActivity:withResolver:withRejecter:)
    func endLiveActivity(activityId: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
        if #available(iOS 16.1, *) {
            if let ongoingActivity = Activity<LiveActivityCountdownWidgetExtensionAttributes>.activities.first(where: { $0.id == activityId }) {
                Task.detached {
                    await ongoingActivity.end()
                    resolve(nil)
                }
            } else {
                reject("END_LIVE_ACTIVITY_NOT_FOUND", "Live activity with id \(activityId) does not exist", nil)
            }
        } else {
            resolve(nil)
        }
    }
    
    // TODO: figure out if it's okay to use RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD due to performance
    // More info: https://reactnative.dev/docs/native-modules-ios#synchronous-methods
    @objc(getLiveActivities:withRejecter:)
    func getLiveActivities(resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) -> Void {
        if #available(iOS 16.1, *) {
            resolve(Activity<LiveActivityCountdownWidgetExtensionAttributes>.activities.map({ $0.id }))
        } else {
            resolve(nil)
        }
    }
}

#import <React/RCTBridgeModule.h>
//#import "LiveActivityCountdown-Swift.h"

@interface RCT_EXTERN_MODULE(LiveActivityCountdown, NSObject)

RCT_EXTERN_METHOD(createLiveActivity:(NSDictionary *)config
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(endLiveActivity:(NSString)activityId
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getLiveActivities:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end

//@interface LiveActivityCountdownReg : NSObject
//@interface RCT_EXTERN_MODULE(LiveActivityCountdownReg, NSObject)
//
//@property (nonatomic, strong) LiveActivityCountdown *liveActivityCountdown;
//
////-(id)init;
//-(id)init {
//    self = [super init];
//    if (self) {
//        self.liveActivityCountdown = [[LiveActivityCountdown alloc] init];
//        if (self.liveActivityCountdown) {
//            [self.liveActivityCountdown registerBackgroundTasks];
//        }
//    }
//    return self;
//}
//
//
//
//RCT_EXTERN_METHOD(createLiveActivity:(NSDictionary *)config
//                  withResolver:(RCTPromiseResolveBlock)resolve
//                  withRejecter:(RCTPromiseRejectBlock)reject)
//
//RCT_EXTERN_METHOD(endLiveActivity:(NSString)activityId
//                  withResolver:(RCTPromiseResolveBlock)resolve
//                  withRejecter:(RCTPromiseRejectBlock)reject)
//
//RCT_EXTERN_METHOD(getLiveActivities:(RCTPromiseResolveBlock)resolve
//                  withRejecter:(RCTPromiseRejectBlock)reject)
//
//+(BOOL)requiresMainQueueSetup
//{
//  return NO;
//}
//
//@end
//
////@implementation LiveActivityCountdownReg
////
////-(id)init {
////    self = [super init];
////    if (self) {
////        self.liveActivityCountdown = [[LiveActivityCountdown alloc] init];
////        if (self.liveActivityCountdown) {
////            [self.liveActivityCountdown registerBackgroundTasks];
////        }
////    }
////    return self;
////}
////
////@end

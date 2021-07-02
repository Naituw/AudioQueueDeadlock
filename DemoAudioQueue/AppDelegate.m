//
//  AppDelegate.m
//  DemoAudioQueue
//
//  Created by Wu Tian on 7/2/21.
//

#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    AudioStreamBasicDescription streamDesc;
    streamDesc.mSampleRate = 44100;
    streamDesc.mChannelsPerFrame = 2;
    streamDesc.mBitsPerChannel = 16;
    streamDesc.mBytesPerFrame = 4;
    streamDesc.mFormatID = kAudioFormatLinearPCM;
    streamDesc.mFormatFlags = kLinearPCMFormatFlagIsPacked | kLinearPCMFormatFlagIsSignedInteger | kAudioFormatFlagsNativeEndian;
    streamDesc.mFramesPerPacket = 1;
    streamDesc.mBytesPerPacket = streamDesc.mBytesPerFrame * streamDesc.mFramesPerPacket;
    
    AudioQueueRef audioQueue;
    AudioQueueNewOutputWithDispatchQueue(&audioQueue,
                                         &streamDesc,
                                         0,
                                         dispatch_queue_create("com.wutian.audioqueue", DISPATCH_QUEUE_SERIAL),
                                         ^(AudioQueueRef inAQ, AudioQueueBufferRef inBuffer) {});
    
    AudioQueueStart(audioQueue, NULL);
    AudioQueueStop(audioQueue, true);
    AudioQueueDispose(audioQueue, true);

    return YES;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

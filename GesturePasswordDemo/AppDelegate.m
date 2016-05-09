//
//  AppDelegate.m
//  GesturePasswordDemo
//
//  Created by apple on 4/29/16.
//  Copyright © 2016 PPF. All rights reserved.
//

#import "AppDelegate.h"
#import "GesturePasswordController.h"
#import "DiskGesturePasswordStore.h"
#import "GesturePasswordViewController.h"
#import "GesturePasswordTestViewController.h"
#import "GesturePasswordControllerDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window, viewController;

static GesturePasswordController *GESTURE_PASSWORD_CONTROLLER = nil;

- (instancetype)init{
    GESTURE_PASSWORD_CONTROLLER = [[GesturePasswordController alloc] initWithStore:[[DiskGesturePasswordStore alloc] init]];

    self = [super init];
    return self;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.viewController = [[GesturePasswordTestViewController alloc] init];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];

    GesturePasswordViewController *gpvc = [[GesturePasswordViewController alloc] init];
    __weak AppDelegate *weakSelf = self;
    [GESTURE_PASSWORD_CONTROLLER setOnViewActionsWithOnReadyReset:^(ViewActionCallbackBlock onViewActionCallback){
        gpvc.mode = MODE_RESET;
        gpvc.onViewActionCallback = onViewActionCallback;
        [weakSelf.viewController presentViewController:gpvc animated:YES completion:nil];
    } onReadyChange:^(ViewActionCallbackBlock viewActionCallback){
        gpvc.mode = MODE_CHANGE;
        gpvc.onViewActionCallback = viewActionCallback;
        [weakSelf.viewController presentViewController:gpvc animated:YES completion:nil];
    } onReadyValidate:^(ViewActionCallbackBlock viewActionCallback) {
        UIViewController *presentedViewController = [weakSelf.viewController presentedViewController];
        if (presentedViewController != nil) {
            GesturePasswordViewController *gpvc2 = [[GesturePasswordViewController alloc] init];
            gpvc2.onViewActionCallback = viewActionCallback;
            [gpvc presentViewController:gpvc2 animated:YES completion:nil];
            return ;
        }

        gpvc.mode = MODE_VALIDATE;
        gpvc.onViewActionCallback = viewActionCallback;
        [weakSelf.viewController presentViewController:gpvc animated:YES completion:nil];
    }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (NSObject <GesturePasswordControllerDelegate> *)getGesturePasswordController {
    return GESTURE_PASSWORD_CONTROLLER;
}

@end

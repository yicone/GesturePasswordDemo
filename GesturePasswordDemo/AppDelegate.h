//
//  AppDelegate.h
//  GesturePasswordDemo
//
//  Created by apple on 4/29/16.
//  Copyright © 2016 PPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GesturePasswordControllerDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow* window;
@property (nonatomic, strong) IBOutlet UIViewController* viewController;

+ (NSObject <GesturePasswordControllerDelegate> *)getGesturePasswordController;
@end


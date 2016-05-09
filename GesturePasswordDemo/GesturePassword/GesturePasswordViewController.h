//
//  TestViewController_TestViewController.h
//  FangJS
//
//  Created by apple on 10/17/15.
//
//

#import <UIKit/UIKit.h>
#import "KKGestureLockView.h"
#import "GesturePasswordView.h"
#import "GesturePasswordController.h"

static const int MODE_VALIDATE = 0;
static const int MODE_RESET = 1;
static const int MODE_RESET_AGAIN = 2;
static const int MODE_CHANGE = 3;


static const int FAIL_COUNT_LIMIT = 5;

@interface GesturePasswordViewController : UIViewController<KKGestureLockViewDelegate, UINavigationBarDelegate, GesturePasswordViewDelegate>


@property(nonatomic, assign) int mode;
@property(nonatomic, strong) ViewActionCallbackBlock onViewActionCallback;

@end

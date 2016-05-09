//
//  Created by apple on 10/22/15.
//
//
#import <Foundation/Foundation.h>
#import "GesturePasswordStore.h"

static NSString *const KEY_CURRENT_UID = @"currentUid";

@interface DiskGesturePasswordStore : NSObject<GesturePasswordStore> {
    NSUserDefaults *userDefaults;
}

@end
//
// Created by apple on 10/8/15.
//

#import <Foundation/Foundation.h>
#import "GesturePasswordStore.h"


@interface MemoryGesturePasswordStore : NSObject<GesturePasswordStore> {
    NSString *currentUid;
    NSMutableDictionary *dictionary;
}

@end


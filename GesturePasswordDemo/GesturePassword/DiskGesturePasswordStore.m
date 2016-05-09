//
//  DiskGesturePasswordStore.m
//  FangJS
//
//  Created by apple on 10/22/15.
//
// dict structure: {KEY_CURRENT_UID: "uid", "uid": "password"}
//
//

#import "DiskGesturePasswordStore.h"

@implementation DiskGesturePasswordStore


- (id)init {

    userDefaults = [NSUserDefaults standardUserDefaults];
    return [super init];
}

- (BOOL)exist:(NSString *)uid {
    return [[userDefaults objectForKey:KEY_CURRENT_UID] isEqualToString:uid];
}

- (NSString *)getPassword:(NSString *)uid {

    return [userDefaults objectForKey:uid];
}

- (void)setPassword:(NSString *)uid :(NSString *)password {
    if (password == nil) {
        [self removeUser:uid];
        return;
    }

    [userDefaults setObject:password forKey:uid];
    [userDefaults synchronize];
}

- (void)removeUser:(NSString *)uid {
    [userDefaults removeObjectForKey:uid];
    [userDefaults removeObjectForKey:KEY_CURRENT_UID];
    [userDefaults synchronize];
}

- (void)setCurrentUser:(NSString *)uid {
    [userDefaults setObject:uid forKey:KEY_CURRENT_UID];
    [userDefaults synchronize];
}

- (NSString *)getCurrentUser {
    return [userDefaults objectForKey:KEY_CURRENT_UID];
}


@end
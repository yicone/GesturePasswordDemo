//
// Created by apple on 10/8/15.
//

#import "MemoryGesturePasswordStore.h"


@implementation MemoryGesturePasswordStore


- (id)init {
    
    dictionary = [[NSMutableDictionary alloc] init];
    return [super init];
}

- (BOOL)exist:(NSString *)uid {
    return [[dictionary allKeys] containsObject:uid];
}

- (NSString *)getPassword:(NSString *)uid {
    return [dictionary valueForKey:uid];
}

- (void)setPassword:(NSString *)uid :(NSString *)password {
    if(password == nil){
        [dictionary removeObjectForKey:uid];
        return;
    }
    
    [dictionary setObject:password forKey:uid];
}

- (void)removeUser:(NSString *)uid {
    [dictionary removeObjectForKey:uid];
}

- (void)setCurrentUser:(NSString *)uid {
    currentUid = uid;
}

- (NSString *)getCurrentUser {
    return currentUid;
}

@end
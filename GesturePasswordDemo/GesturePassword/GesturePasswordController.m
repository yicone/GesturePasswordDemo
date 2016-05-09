//
// Created by apple on 10/8/15.
//

#import "GesturePasswordController.h"


@implementation GesturePasswordController{
    ViewActionBlock _onReadyReset;
    ViewActionBlock _onReadyChange;
    ViewActionBlock _onReadyValidate;
}

@synthesize store = _store;

- (instancetype)initWithStore:(NSObject <GesturePasswordStore> *)store{
    self = [super init];
    if (self) {
        _store = store;
    }
    return self;
}

- (void)setOnViewActionsWithOnReadyReset:(ViewActionBlock)onReadyReset
                  onReadyChange:(ViewActionBlock)onReadyChange
                onReadyValidate:(ViewActionBlock)onReadyValidate{
    _onReadyReset = onReadyReset;
    _onReadyChange = onReadyChange;
    _onReadyValidate = onReadyValidate;
}

- (bool)isEnabled:(NSString *)uid{
    return ([self isCurrentUser:uid]);
}

- (void)enable:(NSString *)uid :(void (^)(int result))callback{
    if (![self isCurrentUser:uid]) {
        void (^callback2)(int) = ^(int result){
            // todo https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html#//apple_ref/doc/uid/TP40011210-CH8-SW16
            if (result == ACTION_RESULT_SUCCESS) {
                [_store setCurrentUser:uid];
            }
            callback(result);
        };
        [self reset:uid :callback2];
    } else {
        callback(ACTION_RESULT_SUCCESS);
    }
}

- (void)forgot{
    [self disable:[_store getCurrentUser]];
}

- (void)disable:(NSString *)uid{
    if (![self isCurrentUser:uid]) {
        return;
    }
    [_store removeUser:uid];
    [_store setCurrentUser:nil];
}

- (bool)validate:(NSString *)password{
    return [[_store getPassword:[_store getCurrentUser]] isEqualToString:password];
}

- (void)validate:(NSString *)uid :(void (^)(int result))callback{
    if (![self isCurrentUser:uid]) {
        callback(ACTION_RESULT_FAIL);
        return;
    }
    
    NSString *userPassword = [_store getPassword:uid];
    ViewActionCallbackBlock onViewActionCallbackListener = ^(int result, NSString *password){
        if (result != ACTION_RESULT_SUCCESS) {
            callback(result);
            return;
        }
        
        BOOL pass = [userPassword isEqualToString:password];
        callback(pass ? ACTION_RESULT_SUCCESS : ACTION_RESULT_FAIL);
    };
    
    _onReadyValidate(onViewActionCallbackListener);
}

- (void)change:(NSString *)uid :(void (^)(int result))callback{
    if (![self isCurrentUser:uid]) {
        callback(ACTION_RESULT_FAIL);
        return;
    }
    
    __weak NSObject <GesturePasswordStore> *weakStore = _store;
    ViewActionCallbackBlock onViewActionCallbackListener = ^(int result, NSString *password){
        if (result == ACTION_RESULT_SUCCESS) {
            [weakStore setPassword:uid :password];
        }
        callback(result);
    };
    
    _onReadyChange(onViewActionCallbackListener);
}

- (void)reset:(NSString *)uid :(void (^)(int result))callback{
    __weak NSObject <GesturePasswordStore> *weakStore = _store;
    ViewActionCallbackBlock onViewActionCallbackListener = ^(int result, NSString *password){
        if (result == ACTION_RESULT_SUCCESS) {
            [weakStore setPassword:uid :password];
        }
        
        callback(result);
    };
    
    _onReadyReset(onViewActionCallbackListener);
}

- (BOOL)isCurrentUser:(NSString *)uid{
    return ([uid isEqualToString:[_store getCurrentUser]]);
}

- (void)dealloc{
    _onReadyReset = nil;
    _onReadyChange = nil;
    _onReadyValidate = nil;
}

@end
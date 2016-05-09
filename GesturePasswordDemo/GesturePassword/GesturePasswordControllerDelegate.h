//
// Created by apple on 10/8/15.
//

#import <Foundation/Foundation.h>

static const int ACTION_RESULT_FAIL = 0;
static const int ACTION_RESULT_SUCCESS = 1;
static const int ACTION_RESULT_FORGOT = 2;
static const int ACTION_RESULT_LOGIN = 3;
static const int ACTION_RESULT_CANCEL = 4;

typedef void(^ViewActionCallbackBlock)(int result, NSString* password);
typedef void(^ViewActionBlock)(ViewActionCallbackBlock onViewActionCallback);


@protocol GesturePasswordControllerDelegate <NSObject>

@required

- (bool)isEnabled:(NSString *)uid;

- (void)enable:(NSString *)uid :(void (^)(int result)) callback;

- (void)forgot;

- (void)disable:(NSString *)uid;

- (bool)validate:(NSString *)password;

- (void)validate:(NSString *)uid :(void (^)(int result)) callback;

- (void)change:(NSString *)uid :(void (^)(int result)) callback;

- (void)reset:(NSString *)uid :(void (^)(int result)) callback;

- (void)setOnViewActionsWithOnReadyReset:(ViewActionBlock)onReadyReset onReadyChange:(ViewActionBlock)onReadyChange onReadyValidate:(ViewActionBlock)onReadyValidate;


@end
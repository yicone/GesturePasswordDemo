//
// Created by apple on 10/9/15.
//

#import <Foundation/Foundation.h>

@protocol GesturePasswordStore <NSObject>

@required

- (BOOL)exist:(NSString *)uid;

- (NSString *)getPassword:(NSString *)uid;

- (void)setPassword:(NSString *)uid :(NSString *)password;

- (void)removeUser:(NSString *)uid;

- (void)setCurrentUser:(NSString *)uid;

- (NSString *)getCurrentUser;

@end
//
// Created by apple on 10/8/15.
//

#import <Foundation/Foundation.h>
#import "GesturePasswordControllerDelegate.h"
#import "GesturePasswordStore.h"



@interface GesturePasswordController : NSObject<GesturePasswordControllerDelegate>{
    
}

@property (nonatomic) NSObject<GesturePasswordStore>* store;

- (id)initWithStore:(NSObject<GesturePasswordStore> *)store;

- (bool)validate:(NSString *)password;

- (void)setOnViewActionsWithOnReadyReset:(ViewActionBlock)onReadyReset onReadyChange:(ViewActionBlock)onReadyChange onReadyValidate:(ViewActionBlock)onReadyValidate;

@end
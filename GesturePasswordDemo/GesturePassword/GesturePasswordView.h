//
//  GesturePasswordView.h
//  FangJS
//
//  Created by apple on 10/15/15.
//
//

#import <UIKit/UIKit.h>
#import <KKGestureLockView/KKGestureLockView.h>

@protocol GesturePasswordViewDelegate<NSObject>

- (void)onForgotClicked;

- (void)onLoginClicked;

- (void)onResetClicked;

@end

@interface GesturePasswordView : UIView

@property(nonatomic, strong) UIButton *btnForgot;

@property(nonatomic, strong) UIButton *btnLogin;

@property(nonatomic, strong) UIButton *btnReset;

@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) KKGestureLockView *lockView;

@property(nonatomic, assign) id<GesturePasswordViewDelegate> delegate;

@end

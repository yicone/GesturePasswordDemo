//
//  TestViewController.m
//  FangJS
//
//  Created by apple on 10/17/15.
//
//

#import "GesturePasswordViewController.h"
#import "AppDelegate.h"


@interface GesturePasswordViewController ()

@end


@implementation GesturePasswordViewController{
    GesturePasswordView *_passwordView;
    NSString *_password;
    UIBarButtonItem *_backButton;
    UINavigationItem *_navItem;
    int _possibleFailCount;
    NSObject <GesturePasswordControllerDelegate> *_gesturePasswordController;
    //    viewActionCallback _onViewActionCallbackListener;
}

@synthesize mode;
@synthesize onViewActionCallback;

- (id)init{
    self = [super init];
    if (self) {
        //        statements
        _possibleFailCount = FAIL_COUNT_LIMIT;
        _gesturePasswordController = [AppDelegate getGesturePasswordController];
        //        _onViewActionCallbackListener = [_gesturePasswordController getOnViewActionCallbackListener];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 61)];
    navBar.delegate = self;
    [navBar setBackgroundImage:[UIImage imageNamed:@"barImage"] forBarMetrics:UIBarMetricsDefault];
    
    _navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:_navItem animated:NO];
    
    [self.view addSubview:navBar];
    
    _backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onBackClicked)];
    [_backButton setTintColor:[UIColor whiteColor]];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _passwordView = [GesturePasswordView new];
    _passwordView.delegate = self;
    _passwordView.lockView.delegate = self;
    
    [self.view addSubview:_passwordView];
    
    UIView *superview = self.view;
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make){
        //        make.edges.equalTo(superview);
        make.top.equalTo(navBar.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.bottom.equalTo(superview.bottom);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    switch (mode) {
        case MODE_VALIDATE: {
            _passwordView.btnForgot.hidden = NO;
            _passwordView.btnLogin.hidden = NO;
            _passwordView.btnReset.hidden = YES;
            _navItem.leftBarButtonItem = nil;
            [_passwordView setTitle:@""];
        }
            break;
        case MODE_RESET: {
            _passwordView.btnForgot.hidden = YES;
            _passwordView.btnLogin.hidden = YES;
            _passwordView.btnReset.hidden = YES;
            _navItem.leftBarButtonItem = _backButton;
            [_passwordView setTitle:@"绘制解锁图案"];
        }
            break;
        case MODE_CHANGE: {
            _passwordView.btnForgot.hidden = YES;
            _passwordView.btnLogin.hidden = YES;
            _passwordView.btnReset.hidden = YES;
            _navItem.leftBarButtonItem = nil;
            [_passwordView setTitle:@"请绘制原解锁图案"];
        }
            break;
    }
}

- (void)onForgotClicked{
    NSLog(@"forgot");
    [_gesturePasswordController forgot];
    
    UIViewController *parentViewController = [self presentingViewController];
    
    if ([parentViewController isKindOfClass:[GesturePasswordViewController class]]) {
        [self dismissViewControllerAnimated:false completion:nil];
        [parentViewController dismissViewControllerAnimated:true completion:nil];
        GesturePasswordViewController *parent = (GesturePasswordViewController*) parentViewController;
        parent.onViewActionCallback(ACTION_RESULT_CANCEL, nil);
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }

    onViewActionCallback(ACTION_RESULT_FORGOT, nil);
}

- (void)onLoginClicked{
    NSLog(@"login");
    UIViewController *parentViewController = [self presentingViewController];
    
    if ([parentViewController isKindOfClass:[GesturePasswordViewController class]]) {
        [self dismissViewControllerAnimated:false completion:nil];
        [parentViewController dismissViewControllerAnimated:true completion:nil];
        GesturePasswordViewController *parent = (GesturePasswordViewController*) parentViewController;
        parent.onViewActionCallback(ACTION_RESULT_CANCEL, nil);
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
    
    onViewActionCallback(ACTION_RESULT_LOGIN, nil);
}

- (void)onResetClicked{
    NSLog(@"reset");
    [_passwordView setTitle:@"绘制解锁图案"];
    mode = MODE_RESET;
    _passwordView.btnReset.hidden = YES;
}


- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    NSLog(@"%@", passcode);
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode{
    NSLog(@"%@", passcode);
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    NSLog(@"%@", passcode);
    
    switch (mode) {
        case MODE_VALIDATE: {
            _passwordView.btnReset.hidden = YES;
            bool pass = [_gesturePasswordController validate:passcode];
            if (!pass) {
                _possibleFailCount--;
                if (_possibleFailCount > 0) {
                    [_passwordView setTitle:[NSString stringWithFormat:@"密码错误，您还能重试%d次", _possibleFailCount]];
                    // todo clear selected
                    // gpw.lockView
                    return;
                }
            }

            _possibleFailCount = FAIL_COUNT_LIMIT;
            onViewActionCallback(ACTION_RESULT_SUCCESS, passcode);
            [self dismissViewControllerAnimated:true completion:nil];
        }
            break;
        case MODE_RESET: {
            NSLog(@"passcode = %@", passcode);
            //因为passcode的输出格式为2,4,5,7数字中间有逗号所以做(passcode.length+1)/2 < 4这样的判断
            if ((passcode.length + 1) / 2 < 4) {
                
                [self alert:@"最少连接4个点，请重新绘制"];
                return;
            }
            
            _passwordView.btnReset.hidden = NO;
            _password = passcode;
            [_passwordView setTitle:@"再次绘制解锁图案"];
            mode = MODE_RESET_AGAIN;
        }
            break;
        case MODE_RESET_AGAIN: {
            _passwordView.btnReset.hidden = YES;
            if ([passcode isEqualToString:_password]) {
                _possibleFailCount = FAIL_COUNT_LIMIT;
                onViewActionCallback(ACTION_RESULT_SUCCESS, passcode);
                [self dismissViewControllerAnimated:true completion:nil];
            } else {
                [self alert:@"两次绘制图案不一致，请重新绘制"];
                [_passwordView setTitle:@"绘制解锁图案"];
                mode = MODE_RESET;
            }
        }
            break;
        case MODE_CHANGE: {
            bool pass = [_gesturePasswordController validate:passcode];
            _passwordView.btnReset.hidden = YES;
            if (!pass) {
                [self alert:@"原密码错误，请重新输入"];
                [_passwordView setTitle:@"请绘制原解锁图案"];
            } else {
                [_passwordView setTitle:@"绘制解锁图案"];
                mode = MODE_RESET;
            }
        }
            break;
        default:
            break;
    }
}

- (void)alert:(NSString *)tips{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:tips delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)onBackClicked{
    NSLog(@"back");
    onViewActionCallback(ACTION_RESULT_CANCEL, nil);
    [self dismissViewControllerAnimated:true completion:nil];
}

@end

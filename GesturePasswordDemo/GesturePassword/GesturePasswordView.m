//
//  GesturePasswordView.m
//  FangJS
//
//  Created by apple on 10/15/15.
//
//

#import "GesturePasswordView.h"

@interface GesturePasswordView (){
    
}
@end


@implementation GesturePasswordView{
    UILabel *lblTitle;
}

@synthesize lockView, title = _title;

- (void)setTitle:(NSString *)title{
    lblTitle.text = title;
}

- (NSString *)title{
    return lblTitle.text;
}

- (id)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat headImgWidth = screenWidth * (8 / 25.0);
        UIImageView *HeadPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth / 2 - headImgWidth / 2, 0, headImgWidth, headImgWidth)];
        HeadPortrait.image = [UIImage imageNamed:@"portrait"];
        
        
        UIImageView *backgroundImage = [UIImageView new];
        [backgroundImage setImage:[UIImage imageNamed:@"gesture_background"]];
        [self addSubview:backgroundImage];
        
        lockView = KKGestureLockView.new;
        lockView.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal"];
        lockView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected"];
        lockView.lineColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        lockView.lineWidth = 12;
        //lockView.delegate = self;
        lockView.contentInsets = UIEdgeInsetsMake(180, 20, 120, 20);
        [self addSubview:lockView];
        [self addSubview:HeadPortrait];
        
        lblTitle = UILabel.new;
        lblTitle.textColor = [UIColor whiteColor];
        [self addSubview:lblTitle];
        
        self.btnForgot = UIButton.new;
        [self.btnForgot setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [self.btnForgot addTarget:self action:@selector(btnForgotClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnForgot];
        
        self.btnLogin = UIButton.new;
        [self.btnLogin setTitle:@"用其他账号登录" forState:UIControlStateNormal];
        [self.btnLogin addTarget:self action:@selector(btnLoginClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnLogin];
        
        self.btnReset = UIButton.new;
        self.btnReset.hidden = YES;
        [self.btnReset setTitle:@"重新设置手势密码" forState:UIControlStateNormal];
        [self.btnReset addTarget:self action:@selector(btnResetClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnReset];
        
        UIView *superview = self;
        
        [backgroundImage makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(superview);
        }];
        
        //if you want to use Masonry without the mas_ prefix
        //define MAS_SHORTHAND before importing Masonry.h see Masonry iOS Examples-Prefix.pch
        [lockView makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(superview.top);
            make.leading.equalTo(superview.leading);
            make.bottom.equalTo(superview.bottom);
            make.trailing.equalTo(superview.trailing);
        }];
        
        [lblTitle makeConstraints:^(MASConstraintMaker *make){
            make.bottom.equalTo(lockView.contentView.top).offset(-20);
            make.centerX.equalTo(superview.centerX);
        }];
        
        [self.btnForgot makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(superview.left).offset(30);
            make.bottom.equalTo(superview.bottom).offset(-20);
        }];
        [self.btnLogin makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(superview.right).offset(-30);
            make.bottom.equalTo(superview.bottom).offset(-20);
        }];
        
        [self.btnReset makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(superview.centerX);
            make.bottom.equalTo(superview.bottom).offset(-20);
        }];
    }
    return self;
}


- (void)btnForgotClicked{
    if ([self.delegate respondsToSelector:@selector(onForgotClicked)]) {
        [self.delegate onForgotClicked];
    }
    
}

- (void)btnLoginClicked{
    if ([self.delegate respondsToSelector:@selector(onLoginClicked)]) {
        [self.delegate onLoginClicked];
    }
}

- (void)btnResetClicked{
    if ([self.delegate respondsToSelector:@selector(onResetClicked)]) {
        [self.delegate onResetClicked];
    }
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

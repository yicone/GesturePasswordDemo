//
//  GesturePasswordTestViewController.h
//  FangJS
//
//  Created by apple on 10/15/15.
//
//

#import <UIKit/UIKit.h>

@interface GesturePasswordTestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnIsEnabled;

@property (nonatomic,retain)IBOutlet UIButton *btnEnable;

@property (nonatomic,retain)IBOutlet UIButton *btnDisable;

@property (nonatomic,retain)IBOutlet UIButton *btnReset;

@property (nonatomic,retain)IBOutlet UIButton *btnChange;

@property (nonatomic,retain) IBOutlet UITextField *txtUid;

@property (nonatomic,retain)IBOutlet UIButton *btnValidate;

- (IBAction)btnIsEnabledClicked:(id)sender;

- (IBAction)btnEnableClicked:(id)sender;

- (IBAction)btnDisableClicked:(id)sender;

- (IBAction)btnResetClicked:(id)sender;

- (IBAction)btnChangeClicked:(id)sender;

- (IBAction)btnValidateClicked:(id)sender;

@end

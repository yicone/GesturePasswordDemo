//
//  GesturePasswordTestViewController.m
//  FangJS
//
//  Created by apple on 10/15/15.
//
//

#import "GesturePasswordTestViewController.h"
#import "AppDelegate.h"
#import "GesturePasswordControllerDelegate.h"
#import "GesturePasswordController.h"
#import "GesturePasswordView.h"

@interface GesturePasswordTestViewController ()

@end

@implementation GesturePasswordTestViewController

@synthesize btnEnable, btnDisable, btnReset, btnChange, btnValidate, txtUid;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnIsEnabledClicked:(id)sender {
    NSString *uid = txtUid.text;
    BOOL ok = [[AppDelegate getGesturePasswordController] isEnabled:uid];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ok?" message:ok? @"YES":@"NO" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)btnEnableClicked:(id)sender {
    NSString *uid = txtUid.text;
    
    [[AppDelegate getGesturePasswordController] enable:uid :^(int result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ok?" message:[NSString stringWithFormat:@"%i", result] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];
}

- (IBAction)btnDisableClicked:(id)sender {
    NSString *uid = txtUid.text;
    [[AppDelegate getGesturePasswordController] disable:uid];
}

- (IBAction)btnResetClicked:(id)sender {
    NSString *uid = txtUid.text;
    [[AppDelegate getGesturePasswordController] reset:uid :^(int result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ok?" message:[NSString stringWithFormat:@"%i", result] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];
}

- (IBAction)btnChangeClicked:(id)sender {
    NSString *uid = txtUid.text;
    [[AppDelegate getGesturePasswordController] change:uid :^(int result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ok?" message:[NSString stringWithFormat:@"%i", result] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];
}

- (IBAction)btnValidateClicked:(id)sender {
    NSString *uid = txtUid.text;
    [[AppDelegate getGesturePasswordController] validate:uid :^(int result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ok?" message:[NSString stringWithFormat:@"%i", result] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];
}

@end

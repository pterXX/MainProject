//
//  IMLoginViewController.m
//  MYIMDemo
//
//  Created by admin on 2019/3/5.
//  Copyright © 2019 徐世杰. All rights reserved.
//

#import "IMLoginViewController.h"
#import "IMSignUpViewController.h"
#import "IMBaseTabBarController.h"
#import <PrivateKit/IMCategory.h>
#import <SVProgressHUD.h>

// 对于block的弱引用
#ifndef kWeakSelf
#define kWeakSelf           __weak __typeof(self) weakSelf = self;
#endif

@interface IMLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton    *signUpBtn;// 注册按钮
@property (nonatomic, strong) UIButton    *signInBtn;// 登录按钮
@property (nonatomic, strong) UILabel     *nameLogo;//  logo
@property (nonatomic, strong) UITextField *passwordField;// 密码
@property (nonatomic, strong) UITextField *userField;// 用户名
@end

#define kTextFieldSize CGSizeMake(325,44);

@implementation IMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTouchEndEditing = YES;
    // Do any additional setup after loading the view.
}



- (void)im_addSubViews{
    //     CGFloat systemVersion = [UIDevice currentSystemVersion].doubleValue;
    //  背景
    [self.view addSubview:({
        UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"bg_login.jpeg"]];
        imageView.contentMode = UIViewContentModeBottom;
        imageView.frame = self.view.bounds;
        imageView;
    })];
    
    
    // logo
    [self.view addSubview:({
        self.nameLogo = [[UILabel alloc] initWithFrame:CGRectMake((IMSCREEN_WIDTH - 320) * 0.5, IMNAVBAR_HEIGHT + IMSTATUSBAR_HEIGHT + 50, 320, 50)];
        self.nameLogo.text          = @"IMDemo Sign In";
        self.nameLogo.textAlignment = NSTextAlignmentCenter;
        self.nameLogo.textColor     = [UIColor whiteColor];
        self.nameLogo.font          = [UIFont fontWithName:@"MarkerFelt-Thin" size:32];
        self.nameLogo;
    })];
    
    CGSize textFieldSize =  kTextFieldSize;
    //  账号
    [self.view addSubview:({
        self.userField      = [self addTextField:@"账号" placeholder:@"请输入账号" ];
        self.userField.size = textFieldSize;
        self.userField.x= (self.view.width - self.userField.width) * 0.5;
        self.userField.y = self.nameLogo.maxY + 40;
        self.userField;
    })] ;
    
    // 密码
    [self.view addSubview:({
        self.passwordField                 = [self addTextField:@"密码" placeholder:@"请输入密码" ];
        self.passwordField.size            = textFieldSize;
        self.passwordField.x           = self.userField.x;
        self.passwordField.y             = self.userField.maxY + 10;
        self.passwordField.secureTextEntry = YES;
        self.passwordField.returnKeyType   = UIReturnKeyGo;
        self.passwordField.delegate        = self;
        self.passwordField;
    })];
    
    //  登录按钮
    [self.view addSubview:({
        NSString *title = @"登录";
        UIColor *titleColor                = [UIColor grayColor];
        UIImage *image                     = [UIImage imageWithColor:[UIColor whiteColor]];
        self.signInBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
        self.signInBtn.x               = self.userField.x;
        self.signInBtn.y                 = self.passwordField.maxY + 20;
        self.signInBtn.size                = textFieldSize;
        self.signInBtn.layer.cornerRadius  = textFieldSize.height * 0.5;
        self.signInBtn.layer.borderColor   = [UIColor whiteColor].CGColor;
        self.signInBtn.layer.borderWidth   = 1;
        self.signInBtn.layer.masksToBounds = (YES);
        [self.signInBtn setTitle:title forState:UIControlStateNormal];
        [self.signInBtn setTitle:title forState:UIControlStateSelected];
        [self.signInBtn setTitle:title forState:UIControlStateFocused];
        [self.signInBtn setTitleColor:titleColor forState:UIControlStateNormal];
        [self.signInBtn setTitleColor:titleColor forState:UIControlStateSelected];
        [self.signInBtn setTitleColor:titleColor forState:UIControlStateFocused];
        [self.signInBtn setBackgroundImage:image forState:UIControlStateNormal];
        [self.signInBtn setBackgroundImage:image forState:UIControlStateSelected];
        [self.signInBtn setBackgroundImage:image forState:UIControlStateFocused];
        self.signInBtn;
    })];
   
    //  注册按钮
    [self.view addSubview:({
        NSString *title = @"没有账号?注册新用户";
        UIColor *titleColor                = [UIColor whiteColor];
        self.signUpBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
        self.signUpBtn.x               = self.userField.x;
        self.signUpBtn.maxY              = self.view.height - 100;
        self.signUpBtn.size                = textFieldSize;
        self.signUpBtn.titleLabel.font     = [UIFont systemFontOfSize:14];
        [self.signUpBtn setTitle:title forState:UIControlStateNormal];
        [self.signUpBtn setTitle:title forState:UIControlStateSelected];
        [self.signUpBtn setTitle:title forState:UIControlStateFocused];
        [self.signUpBtn setTitleColor:titleColor forState:UIControlStateNormal];
        [self.signUpBtn setTitleColor:titleColor forState:UIControlStateSelected];
        [self.signUpBtn setTitleColor:titleColor forState:UIControlStateFocused];
        self.signUpBtn;
    })];
    
     [self signBtnWithEvents];
}


/**
 登录按钮的点击
 */
- (void)signBtnWithEvents{
    kWeakSelf;
    //  点击事件
    [self.signInBtn addIMCallBackAction:^(UIButton *button) {
        button.enabled = NO;
        button.alpha = 0.5f;
    } forControlEvents:UIControlEventTouchDown];
    //  手指提起的事件
    [self.signInBtn addIMCallBackAction:^(UIButton *button) {
        button.enabled = YES;
        button.alpha = 1.0f;
        [weakSelf signIn];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.signUpBtn addIMCallBackAction:^(UIButton *button) {
        button.enabled = NO;
        button.alpha = 0.5f;
    } forControlEvents:UIControlEventTouchDown];
    //  手指提起的事件
    [self.signUpBtn addIMCallBackAction:^(UIButton *button) {
        button.enabled = YES;
        button.alpha = 1.0f;
        [weakSelf signUp];
    } forControlEvents:UIControlEventTouchUpInside];
}

/**
 初始化TextField
 
 @param title 标题
 @param placeholder 占位名
 @return 初始化后的UITextField
 */
- (UITextField *)addTextField:(NSString *)title placeholder:(NSString *)placeholder
{
    CGSize textFieldSize = kTextFieldSize;
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, textFieldSize.height)];
    label.text          = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font          = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    
    UITextField *textField           = [[UITextField alloc] init];
    textField.font                   = [UIFont systemFontOfSize:16];
    textField.textColor              = [UIColor whiteColor];
    textField.leftView               = label;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.leftViewMode           = UITextFieldViewModeAlways;
    textField.placeholder            = placeholder;
    textField.tintColor              = [UIColor whiteColor];
    textField.layer.cornerRadius     = textFieldSize.height * 0.5;
    textField.layer.borderColor      = [UIColor whiteColor].CGColor;
    textField.layer.borderWidth      = 1;
    textField.layer.masksToBounds = (YES);
    [textField setValue:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7] forKeyPath:@"_placeholderLabel.textColor"];
    return textField;
}


/**
 检查文本输入框是否有值
 
 @return BOOL yes 表示有值 NO便是不存在值
 */
- (BOOL)checkTextFieldForValue{
    BOOL ok =  YES;
    if ([self.userField.text isEmptyString]) {
        ok = NO;
        [SVProgressHUD showInfoWithStatus:self.userField.placeholder];
        [SVProgressHUD dismissWithDelay:2];
    }else if ([self.passwordField.text isEmptyString]) {
        ok = NO;
        [SVProgressHUD showInfoWithStatus:self.passwordField.placeholder];
        [SVProgressHUD dismissWithDelay:2];
    }
    
    return ok;
}


/**
 登录
 */
- (void)signIn{
    kWeakSelf;
    [self.view endEditing:YES];
    if ([self checkTextFieldForValue]) {
        NSString *username = self.userField.text;
        NSString *password = self.passwordField.text;//123456
        !self.LoggingBlock?:self.LoggingBlock(username,password,^{
            [self loginSuccess];
        });
    }
}


/**
 注册
 */
- (void)signUp{
    [self.view endEditing:YES];
    IMSignUpViewController *vc = [[IMSignUpViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    vc.registeringBlock = self.registeringBlock;
    [self presentViewController:vc animated:YES completion:nil];
}


/**
 实现UITextField代理方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self signIn];
    return YES;
}

#pragma mark - notification event

/**
 登录成功
 */
- (void)loginSuccess{
    if (self.loginSuccessBlock) {
        NSString *username = self.userField.text;
        NSString *password = self.passwordField.text;//123456
        self.loginSuccessBlock(username,password);
    }
}
@end

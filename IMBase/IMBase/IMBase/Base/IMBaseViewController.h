//
//  IMBaseViewController.h
//  MYIMDemo
//
//  Created by 徐世杰 on 2019/2/28.
//  Copyright © 2019 徐世杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMBaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMBaseViewController : UIViewController
/**
 是否触摸屏幕
 */
@property (assign,nonatomic) BOOL isTouchEndEditing;

/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (assign,nonatomic) BOOL isExtendLayout;


/**
 * 功能：设置修改StatusBar
 * 参数：（1）StatusBar样式：statusBarStyle
 *      （2）是否隐藏StatusBar：statusBarHidden
 *      （3）是否动画过渡：animated
 */

-(void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
            statusBarHidden:(BOOL)statusBarHidden
    changeStatusBarAnimated:(BOOL)animated;

/**
 * 功能：隐藏显示导航栏
 * 参数：（1）是否隐藏导航栏：isHide
 *      （2）是否有动画过渡：animated
 */
-(void)hideNavigationBar:(BOOL)isHide
                animated:(BOOL)animated;


/**
 *  功能:  布局导航栏下的分割线
 */
- (void)im_removeNavgationBarLine;

/**
 * 功能： 布局导航栏界面
 * 参数：（1）导航栏背景：backGroundImage
 *      （2）导航栏标题颜色：titleColor
 *      （3）导航栏标题字体：titleFont
 *      （4）导航栏左侧按钮：leftItem
 *      （5）导航栏右侧按钮：rightItem
 */
-(void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem;


/**
 自动根据导航栏判断过渡方式
 
 @param vc 需要过渡的页面
 @param animated 是否显示动画
 */
- (void)showToViewController:(UIViewController *)vc animated:(BOOL)animated;

/**
 *  初始化一个nav
 */
- (IMBaseNavigationController *)im_initializeNavigationController;
+ (IMBaseNavigationController *)im_initializeNavigationControllerForVc:(UIViewController *)vc;

/**
 * 返回的操作
 */
- (void)im_backHandle;

/**
 *  添加控件
 */
- (void)im_addSubViews;
/**
 *  绑定
 */
- (void)im_bindViewModel;
- (void)im_layoutNavigation;
- (void)im_getNewData;
- (void)im_showHUD;
- (void)im_hideHUD;


- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;
@end


NS_ASSUME_NONNULL_END

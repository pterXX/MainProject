//
//  IMSignUpViewController.h
//  MYIMDemo
//
//  Created by admin on 2019/3/7.
//  Copyright © 2019 徐世杰. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <IMBase/IMBaseViewController.h>
#import "IMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMSignUpViewController : IMBaseViewController
@property (nonatomic ,copy) void(^registeringBlock)(NSString *user,NSString *password,void(^success)(void));
@end

NS_ASSUME_NONNULL_END

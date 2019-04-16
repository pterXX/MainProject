//
//  ViewController.m
//  IMBase
//
//  Created by admin on 2019/4/16.
//  Copyright © 2019 admin. All rights reserved.
//

#import "ViewController.h"
#import <PrivateKit/IMCategory.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"这是导航栏";
    initTabBarItem(self.navigationController.tabBarItem, @"view", nil, nil);
}

- (void)im_addSubViews{
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"这是通过父类'IMBaseViewController '方法im_addSubViews 添加的label";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, IMSCREEN_WIDTH, IMSCREEN_HEIGHT);
        label;
    })];
}



@end

//
//  SuspendButtonViewController.h
//  suspendBtnDemo
//
//  Created by 郭永红 on 2016/10/19.
//  Copyright © 2016年 郭永红. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface SuspendButtonViewController : UIViewController

//悬浮小按钮、也可以是个UIView
@property (nonatomic, strong) UIButton *spButton;

/*
 *悬浮按钮点击事件
 *
 */
- (void)suspendBtnClicked:(id)sender;

/*
 *设置悬浮小按钮
 */
- (void)configSuspendButton;

@end

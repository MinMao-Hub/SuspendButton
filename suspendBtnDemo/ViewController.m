//
//  ViewController.m
//  suspendBtnDemo
//
//  Created by 郭永红 on 2016/10/19.
//  Copyright © 2016年 郭永红. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 *重写悬浮按钮点击事件
 */
- (void)suspendBtnClicked:(id)sender
{
    [super suspendBtnClicked:sender];
    
    UIViewController *aVC = [[UIViewController alloc] init];
    aVC.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:aVC animated:YES];
}

/*
*重写悬浮按钮的一些属性
 */
- (void)configSuspendButton
{
    [super configSuspendButton];
    self.spButton.layer.cornerRadius = 0;
    self.spButton.layer.borderWidth = 0.5;
    self.spButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.spButton setImage:[UIImage imageNamed:@"suspendImage"] forState:UIControlStateNormal];
}

@end

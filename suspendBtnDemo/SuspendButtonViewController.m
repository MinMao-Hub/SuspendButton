//
//  SuspendButtonViewController.m
//  suspendBtnDemo
//
//  Created by 郭永红 on 2016/10/19.
//  Copyright © 2016年 郭永红. All rights reserved.
//

/*
 SuspendButtonViewController
 
 简单的悬浮按钮，类似于苹果手机桌面的悬浮菜单按钮

 */


#import "SuspendButtonViewController.h"

// 屏幕高度
#define susScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽度
#define susScreenW [UIScreen mainScreen].bounds.size.width

//悬浮按钮宽高
#define kSuspendBtnWidth 60 * susScreenW / 375

@interface SuspendButtonViewController ()

@end

@implementation SuspendButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSuspendButton];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:_spButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_spButton removeFromSuperview];
}

//设置悬浮按钮
- (void)configSuspendButton
{
    self.spButton = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"suspendImage"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(susScreenW - kSuspendBtnWidth, 200, kSuspendBtnWidth, kSuspendBtnWidth);
        // 按钮点击事件
        [btn addTarget:self action:@selector(suspendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor clearColor];
        // 禁止高亮
        btn.adjustsImageWhenHighlighted = NO;
        // 置顶（只是显示置顶，但响应事件会被后来者覆盖！）
        btn.layer.zPosition = 1;
        
        //创建移动手势事件
        UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [panRcognize setMinimumNumberOfTouches:1];
        [panRcognize setEnabled:YES];
        [panRcognize delaysTouchesEnded];
        [panRcognize cancelsTouchesInView];
        [btn addGestureRecognizer:panRcognize];
        
        btn;
    });
}

//悬浮按钮点击
- (void)suspendBtnClicked:(id)sender
{
    NSLog(@"悬浮按钮点击啦~~~~~~~~~~");
}


/*
 *  悬浮按钮移动事件处理
 */
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.navigationController.view];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = CGPointMake(0, susScreenH / 2.0);
            
            if (recognizer.view.center.x < susScreenW / 2.0) {
                if (recognizer.view.center.y <= susScreenH/2.0) {
                    //左上
                    if (recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kSuspendBtnWidth/2.0);
                    }else{
                        stopPoint = CGPointMake(kSuspendBtnWidth/2.0, recognizer.view.center.y);
                    }
                }else{
                    //左下
                    if (recognizer.view.center.x  >= susScreenH - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, susScreenH - kSuspendBtnWidth/2.0);
                    }else{
                        stopPoint = CGPointMake(kSuspendBtnWidth/2.0, recognizer.view.center.y);
                    }
                }
            }else{
                if (recognizer.view.center.y <= susScreenH/2.0) {
                    //右上
                    if (susScreenW - recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, kSuspendBtnWidth/2.0);
                    }else{
                        stopPoint = CGPointMake(susScreenW - kSuspendBtnWidth/2.0, recognizer.view.center.y);
                    }
                }else{
                    //右下
                    if (susScreenW - recognizer.view.center.x  >= susScreenH - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x, susScreenH - kSuspendBtnWidth/2.0);
                    }else{
                        stopPoint = CGPointMake(susScreenW - kSuspendBtnWidth/2.0,recognizer.view.center.y);
                    }
                }
            }
            
            if (stopPoint.x - kSuspendBtnWidth/2.0 <= 0) {
                stopPoint = CGPointMake(kSuspendBtnWidth/2.0, stopPoint.y);
            }
            
            if (stopPoint.x + kSuspendBtnWidth/2.0 >= susScreenW) {
                stopPoint = CGPointMake(susScreenW - kSuspendBtnWidth/2.0, stopPoint.y);
            }
            
            if (stopPoint.y - kSuspendBtnWidth/2.0 <= 0) {
                stopPoint = CGPointMake(stopPoint.x, kSuspendBtnWidth/2.0);
            }
            
            if (stopPoint.y + kSuspendBtnWidth/2.0 >= susScreenH) {
                stopPoint = CGPointMake(stopPoint.x, susScreenH - kSuspendBtnWidth/2.0);
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
            
        default:
            break;
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

@end

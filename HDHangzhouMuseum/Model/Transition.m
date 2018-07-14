//
//  Transition.m
//  HDHangzhouMuseum
//
//  Created by hengda2015mini on 16/2/23.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import "Transition.h"

@implementation Transition

// 转场时的动画动画设置和对View的设置都写在此方法中
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //*****************动画效果1：渐渐消失中渐渐展现
    UIViewController *project = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    project.view.alpha = 0.0;
    CGRect frame = containerView.bounds;
    project.view.frame = frame;
    [containerView addSubview:project.view];
    
    [UIView animateWithDuration:0.9 animations:^{
        project.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}


// 转场动画展现时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.9;
}


@end













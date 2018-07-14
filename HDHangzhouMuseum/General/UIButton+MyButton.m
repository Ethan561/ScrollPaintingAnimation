//
//  UIButton+MyButton.m
//  HDHangzhouMuseum
//
//  Created by hengdaliuyi on 16/3/1.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import "UIButton+MyButton.h"

@implementation UIButton (MyButton)

+ (UIButton *)initWithFrame:(CGRect)frame
                       type:(UIButtonType)type
            backgroundImage:(UIImage *)image
                     target:(id)target
                     action:(SEL)selector
                        tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



@end
























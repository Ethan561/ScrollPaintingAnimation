//
//  UIButton+MyButton.h
//  HDHangzhouMuseum
//
//  Created by hengdaliuyi on 16/3/1.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MyButton)
+ (UIButton *)initWithFrame:(CGRect)frame
                         type:(UIButtonType)type
              backgroundImage:(UIImage *)image
                       target:(id)target
                       action:(SEL)selector
                          tag:(NSInteger)tag;
@end












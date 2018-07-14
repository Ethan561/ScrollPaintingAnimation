//
//  UIImageView+MyImageView.m
//  HDHangzhouMuseum
//
//  Created by hengdaliuyi on 16/3/1.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import "UIImageView+MyImageView.h"

@implementation UIImageView (MyImageView)
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    imageV.image = image;
    
    return imageV;
    
}
@end

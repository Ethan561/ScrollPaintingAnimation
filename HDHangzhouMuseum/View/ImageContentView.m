//
//  ImageContentView.m
//  HDHangzhouMuseum
//
//  Created by hengda2015mini on 16/2/24.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import "ImageContentView.h"

@implementation ImageContentView

- (instancetype)initWithFrame:(CGRect)frame  image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _picture = [[UIImageView alloc]initWithFrame:self.bounds];
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        _picture.image = image;
        [self addSubview:_picture];
    }
    return self;
    
}

- (void)imageOffset
{
    //将当前视图的Rect转化为在window上的Rect
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    //获取当前视图在window坐标下中心点的Y坐标
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    
//    LOG(@"centerY:%f",centerY);
    
    //获取父视图的中心坐标,为屏幕高度的一半
    CGPoint windowCenter = self.superview.center;
//    LOG(@"self.superview:%f",self.superview.center.y);
    //获取y坐标下的相对偏移量
    CGFloat cellOffsetY = centerY - windowCenter.y;
//    LOG(@"cellOffsetY:%f",cellOffsetY);
    CGFloat offsetDig = cellOffsetY / self.superview.frame.size.height;
//    LOG(@"offsetDig:%f",offsetDig);
    
    CGFloat offset =  offsetDig * (ScreenHeight/1.7 - 200)/2;
//  NSLog(@"offset:%f",offset);
    
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
       
    self.picture.transform = transY;
    
//    LOG(@"****************");
    
}

- (void)imageOffset1
{
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    
    CGPoint windowCenter = self.superview.center;
    CGFloat cellOffsetY = centerY - windowCenter.y;
    CGFloat offsetDig = cellOffsetY / self.superview.frame.size.height;
    
    CGFloat offset =  offsetDig * (ScreenHeight/1.7 - 100)/2;
    
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    
    self.picture.transform = transY;
    
}



@end









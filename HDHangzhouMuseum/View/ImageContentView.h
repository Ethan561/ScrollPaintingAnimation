//
//  ImageContentView.h
//  HDHangzhouMuseum
//
//  Created by hengda2015mini on 16/2/24.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageContentView : UIView

@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic) BOOL isFaster;
@property (nonatomic) NSInteger index;
//- (instancetype)initWithFrame:(CGRect)frame Width:(CGFloat)width  collor:(UIColor *)collor;
- (instancetype)initWithFrame:(CGRect)frame  image:(UIImage *)image;

- (void)imageOffset;
- (void)imageOffset1;



@end

















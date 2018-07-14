//
//  GIFImageView.h
//  新年快乐
//
//  Created by hengda2015mini on 16/1/30.
//  Copyright © 2016年 liuyi. All rights reserved.
//

/*******************************************************
 *  依赖:
 *      - QuartzCore.framework
 *      - ImageIO.framework
 *  参数:
 *      以下传参2选1：
 *      - gifData       GIF图片的NSData
 *      - gifPath       GIF图片的本地路径
 *  调用:
 *      - startGIF      开始播放
 *      - stopGIF       结束播放
 *      - isGIFPlaying  判断是否正在播放
 *  另外：
 *      想用 category？请使用 UIImageView+PlayGIF.h/m
 *******************************************************/

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>

@interface GIFImageView : UIImageView
@property (nonatomic, strong) NSString *gifPath;
@property (nonatomic, strong) NSData   *gifData;

- (void)startGIF;
- (void)stopGIF;
- (BOOL)isGIFPlaying;
- (void)imageOffset;

@end
















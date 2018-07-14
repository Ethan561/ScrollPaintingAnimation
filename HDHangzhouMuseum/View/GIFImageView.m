//
//  GIFImageView.m
//  新年快乐
//
//  Created by hengda2015mini on 16/1/30.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import "GIFImageView.h"
#import <Foundation/Foundation.h>

//GIFManager
@interface GIFManager : NSObject
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSHashTable *gifViewHashTable;

+ (GIFManager *)shared;
- (void)stopGIFView:(GIFImageView *)view;

@end

@implementation GIFManager
+ (GIFManager *)shared
{
    static GIFManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[GIFManager alloc] init];
    });
    return _sharedInstance;
}

- (id)init{
    self = [super init];
    if (self)
    {
        _gifViewHashTable = [NSHashTable hashTableWithOptions:NSHashTableWeakMemory];
    }
    return self;
}

- (void)play{
    for (GIFImageView *imageView in _gifViewHashTable)
    {
        [imageView performSelector:@selector(play)];
    }
}

- (void)stopDisplayLink
{
    if (self.displayLink)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
        [self.gifViewHashTable removeAllObjects];
        self.gifViewHashTable = nil;
    }
}
- (void)stopGIFView:(GIFImageView *)view
{
    [_gifViewHashTable removeObject:view];
    if (_gifViewHashTable.count < 1 && !_displayLink)
    {
        [self stopDisplayLink];
    }
}


@end




/**
 *  ********************************************************************
 */
#import "GIFImageView.h"

@interface GIFImageView ()

{
    size_t              _index;
    size_t              _frameCount;
    float               _timestamp;
    CGImageSourceRef    _gifSourceRef;
}

@end

@implementation GIFImageView

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self stopGIF];
}

- (void)startGIF{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        if (![[GIFManager shared].gifViewHashTable containsObject:self]) {
            //判断路径是否存在
            if ((self.gifData || self.gifPath)) {
//                CGImageSourceRef gifSourceRef;
                if (self.gifData) {
                    _gifSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)(self.gifData), NULL);
//                CFRelease(_gifSourceRef);
                }else{
                    _gifSourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:self.gifPath], NULL);
//                     CFRelease(_gifSourceRef);
                }
                if (!_gifSourceRef) {
                    return;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[GIFManager shared].gifViewHashTable addObject:self];
//                    _gifSourceRef = gifSourceRef;
                    _frameCount = CGImageSourceGetCount(_gifSourceRef);
                });
//               CGImageSourceRemoveCacheAtIndex(gifSourceRef, _frameCount);
            
            }
        }
    });
    if (![GIFManager shared].displayLink) {
        [GIFManager shared].displayLink = [CADisplayLink displayLinkWithTarget:[GIFManager shared] selector:@selector(play)];
        [[GIFManager shared].displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    }
}

- (void)stopGIF{
    if (_gifSourceRef)
    {
        CFRelease(_gifSourceRef);
        _gifSourceRef = nil;
    }
    [[GIFManager shared] stopGIFView:self];
}

- (void)play{
    float nextFrameDuration = [self frameDurationAtIndex:MIN(_index+1, _frameCount-1)];
    if (_timestamp < nextFrameDuration) {
        _timestamp += [GIFManager shared].displayLink.duration;
        return;
    }
    _index ++;
    _index = _index % _frameCount;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gifSourceRef, _index, NULL);
    self.layer.contents = (__bridge id)(ref);
    CGImageRelease(ref);
    _timestamp = 0;
}

- (float)frameDurationAtIndex:(size_t)index{
    CFDictionaryRef dictRef = CGImageSourceCopyPropertiesAtIndex(_gifSourceRef, index, NULL);
    NSDictionary *dict = (__bridge NSDictionary *)dictRef;
    NSDictionary *gifDict = (dict[(NSString *)kCGImagePropertyGIFDictionary]);
    NSNumber *unclampedDelayTime = gifDict[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    NSNumber *delayTime = gifDict[(NSString *)kCGImagePropertyGIFDelayTime];
    CFRelease(dictRef);
    if (unclampedDelayTime.floatValue) {
        return unclampedDelayTime.floatValue;
    }else if (delayTime.floatValue) {
        return delayTime.floatValue;
    }else{
        return 1/24.0;
    }
}

- (BOOL)isGIFPlaying{
    return _gifSourceRef?YES:NO;
}

- (void)imageOffset {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;

    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    CGFloat offsetDig = cellOffsetY / self.superview.frame.size.height *2;
    CGFloat offset =  offsetDig * (ScreenHeight/1.7 - 250)/2;
    
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    
  
    self.transform = transY;
    
    
    NSLog(@"****************");
    
}


@end



















































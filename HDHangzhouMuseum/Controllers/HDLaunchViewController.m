//
//  HDLaunchViewController.m
//  HDHangzhouMuseum
//
//  Created by hengda2015mini on 16/2/23.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import "HDLaunchViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Transition.h"
#import "HDRootViewController.h"


//考虑转屏的影响，按照实际屏幕方向（UIDeviceOrientation）的宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)

@interface HDLaunchViewController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *containerView;

@property (nonatomic, strong)AVPlayer *player;

@end


@implementation HDLaunchViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    HDRootViewController *rootVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"HDRootVC"];
    [self.navigationController pushViewController:rootVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
//    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"launchVideo" ofType:@"mp4"];
//    NSURL *URL1 = [[NSURL alloc] initFileURLWithPath:urlStr];
//    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:URL1 options:nil];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//
//    _player = [AVPlayer playerWithPlayerItem:playerItem];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    playerLayer.frame = CGRectMake(0,0, ScreenWidth, ScreenHeight);
//    [self.containerView.layer addSublayer:playerLayer];
//    [self setAVAudioSession];
//    [_player setVolume:1.0];
//    [_player play];
    
    
    //监控 app 活动状态，打电话/锁屏 时暂停播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    //注册视频播放完后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //添加跳过按钮
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"])
    {
//        LOG(@"第一次启动");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
    }else{
//        LOG(@"不是第一次启动");
        UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tapBtn.frame = CGRectMake(ScreenWidth / 2.0 - 30, ScreenHeight - 60, 60, 40);
        [tapBtn addTarget:self action:@selector(playerItemDidReachEnd:) forControlEvents:UIControlEventTouchUpInside];
        tapBtn.backgroundColor = [UIColor grayColor];
        [tapBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [self.containerView addSubview:tapBtn];
    }
}

- (void)setAVAudioSession
{
    BOOL success = NO;
    NSError *error = nil;
    AVAudioSession *audioSessionObj = [AVAudioSession sharedInstance];
    success = [audioSessionObj setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    if ([self hasMicphone] == NO) {
        [audioSessionObj setCategory:AVAudioSessionCategoryPlayback error:&error];
    }
    if (!success) {
    //NSLog(@"Error setting category:%@",[error localizedDescription]);
        return;
    }
    success = [audioSessionObj setActive:true error:&error];
    if (!success) {
    //NSLog(@"Error setting category:%@",[error localizedDescription]);
        return;
    }

    //监听耳机事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outputDeviceChanged:)name:AVAudioSessionRouteChangeNotification
                                               object:[AVAudioSession sharedInstance]];
    
    
    
}
- (void)outputDeviceChanged:(NSNotification *)aNotification
{
    //拔出耳机后仍播放
    [self.player play];
}

- (BOOL)hasMicphone
{
    if ([[AVAudioSession sharedInstance] isInputAvailable] == NO)
        return NO;
    
    // 判断是否有耳机
    AVAudioSessionRouteDescription *des = [[AVAudioSession sharedInstance] currentRoute];
    NSArray *a = des.outputs;
    for (AVAudioSessionPortDescription *s in a) {
        if ([s.portType isEqualToString:AVAudioSessionPortHeadsetMic] || [s.portType isEqualToString:AVAudioSessionPortHeadphones]) {
        LOG(@"耳机");
            return YES;
        }
    }
    
    return NO;
}


#pragma mark - UINavigationControllerDelegate iOS7新增的2个方法
// 动画特效
- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [Transition new];
}


// 交互
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController						   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    /**
     *  在非交互式动画效果中，该方法返回 nil
     *  交互式转场,自我理解意思是,用户能通过自己的动作来(常见:手势)控制,不同于系统缺省给定的push或者pop(非交互式)
     */
    return nil;
}

#pragma mark - action
/*
 *程序活动的动作
 */
- (void)becomeActive
{
//    [self.player play];
}

/*
 *程序不活动的动作
 */
- (void)resignActive
{
//  [self.player pause];
}

//视频播放到结尾
- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    [UIView animateWithDuration:5.0 animations:^{

    } completion:^(BOOL finished) {
        
        HDRootViewController *rootVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"HDRootVC"];
        [self.navigationController pushViewController:rootVC animated:YES];
//        [self.player pause];
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [self.player.currentItem cancelPendingSeeks];
//    [self.player.currentItem.asset cancelLoading];
//    self.player = nil;
//    [self.player replaceCurrentItemWithPlayerItem:nil];
}

- (void)dealloc
{
    self.containerView = nil;
    self.player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

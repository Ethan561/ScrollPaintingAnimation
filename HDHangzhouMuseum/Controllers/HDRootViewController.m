//
//  HDRootViewController.m
//  HDHangzhouMuseum
//
//  Created by hengda2015mini on 16/2/23.
//  Copyright © 2016年 liuyi. All rights reserved.
//

#import "HDRootViewController.h"
#import "ImageContentView.h"
#import "GIFImageView.h"
#import "AppDelegate.h"
#import "TestViewController.h"
#import "UIButton+MyButton.h"
#import "UIImageView+MyImageView.h"

@interface HDRootViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) UIView *myView1;
@property (nonatomic,strong) ImageContentView *Cherry;
@property (nonatomic,strong) ImageContentView *Bamboo;
@property (nonatomic,strong) ImageContentView *PlumFlower;
@property (nonatomic,strong) GIFImageView *fly1;
@property (nonatomic,strong) GIFImageView *fly2;
@property (nonatomic,strong) GIFImageView *fly3;

@end


@implementation HDRootViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//  self.navigationController.delegate = self;
    [_fly1 startGIF];
    [_fly2 startGIF];
    [_fly3 startGIF];
    _scrollView.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:_scrollView];
    float picHeight = ScreenWidth * 7972 /1242.0;
    _scrollView.contentSize = CGSizeMake(ScreenWidth,picHeight);
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, picHeight)];
    imageV.image = [UIImage imageNamed:@"rootImage1"];
    [_scrollView addSubview:imageV];

    [self addScrollViewSubviews];
//  [self addButterflyAnimations];
    [self addEmitterAnimations];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_fly1 stopGIF];
    [_fly2 stopGIF];
    [_fly3 stopGIF];
    _scrollView.delegate = nil;
//  _scrollView = nil;
}
- (void)pushAction
{
    TestViewController *rootVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"TestView"];
    [self.navigationController pushViewController:rootVC animated:YES];
}
- (void)addScrollViewSubviews
{
  
    //蝴蝶1
    _fly1 = [[GIFImageView alloc] initWithFrame:CGRectMake1(204, 187, 60, 43)];
    [_scrollView addSubview:_fly1];
    _fly1.gifPath = [[NSBundle mainBundle] pathForResource:@"butterfly" ofType:@"gif"];
    [_fly1 startGIF];
    
    /*
    //得到图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"butterfly" ofType:@"gif"];
    //将图片转为NSData
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    //创建一个webView，添加到界面
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 150, 200, 200)];
    [self.scrollView addSubview:webView];
    //自动调整尺寸
    webView.scalesPageToFit = YES;
    //禁止滚动
    webView.scrollView.scrollEnabled = NO;
    //设置透明效果
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = 0;
    //加载数据
    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:[NSURL URLWithString:path]];
    */
    
    //关键帧动画
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(ScreenWidth, 450)];
    [bezierPath addCurveToPoint:CGPointMake(0, 450) controlPoint1:CGPointMake(275, 200) controlPoint2:CGPointMake(150, 550)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.strokeColor = [UIColor clearColor].CGColor;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.scrollView.layer addSublayer:pathLayer];
    //
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 30.0;
//  animation.rotationMode = kCAAnimationRotateAutoReverse;
    animation.path = bezierPath.CGPath;
    animation.repeatCount = 100;
    [_fly1.layer addAnimation:animation forKey:nil];
    
    //蝴蝶2
    _fly2 = [[GIFImageView alloc] initWithFrame:CGRectMake1(187, 229, 40, 26)];
    [_scrollView addSubview:_fly2];
    _fly2.gifPath = [[NSBundle mainBundle] pathForResource:@"butterfly" ofType:@"gif"];
    [_fly2 startGIF];
    
    //logo
    ImageContentView *logo = [[ImageContentView alloc] initWithFrame:CGRectMake1(145, 283, 55, 226) image:[UIImage imageNamed:@"Logo"]];
    [_scrollView addSubview:logo];
    
    //樱花
    _Cherry = [[ImageContentView alloc] initWithFrame:CGRectMake1(149, 599, 155, 245) image:[UIImage imageNamed:@"Cherry"]];
    [_scrollView addSubview:_Cherry];
    //雷峰塔
    ImageContentView *pagoda = [[ImageContentView alloc] initWithFrame:CGRectMake1(73, 700, 147, 209) image:[UIImage imageNamed:@"pagoda"]];
    pagoda.isFaster = YES;
    pagoda.tag = 101;
    _myView = [[UIView alloc] initWithFrame:CGRectMake1(23, 700, 60, 160)];
    _myView.backgroundColor = [UIColor clearColor];
    UITextView *textView = [[UITextView alloc] initWithFrame:_myView.bounds];
    [_myView addSubview:textView];
    textView.editable = NO;
    textView.text = @"雷峰塔（Leifeng Pagoda）又名皇妃塔、西关砖塔，位于浙江省会杭州市西湖风景区岸夕照山的雷峰上。雷峰塔为吴越国王钱俶因黄妃得子建，初名“皇妃塔”因地建于雷峰，后人改称“雷峰塔”。汉族民间故事《白蛇传》中，法海和尚骗许仙至金山，白娘子水漫金山救许仙，被法海镇在雷峰塔下。后小青苦练法力,终于打败了法海,雷峰塔倒塌，白素贞才获救了。";
    textView.font = [UIFont systemFontOfSize:12];
    textView.directionalLockEnabled = NO;
    textView.backgroundColor = [UIColor clearColor];
    
    [_scrollView addSubview:_myView];
    _myView.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animatetion:)];
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
//    [longPress addTarget:self action:@selector(animatetion:)];
    
//    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 147, 209)];
//    btnView.backgroundColor = [UIColor clearColor];
//    [pagoda addSubview:btnView];
//    [btnView addGestureRecognizer:tap];
    [pagoda addGestureRecognizer:tap];
//  pagoda.index = 111;
    [_scrollView addSubview:pagoda];
    
    //简介按钮
    UIButton *introduceBtn = [UIButton initWithFrame:CGRectMake1(50, 586, 28, 87) type:UIButtonTypeCustom backgroundImage:[UIImage imageNamed:@"IntroduceBtn"] target:self action:@selector(pushAction) tag:0];
    [_scrollView addSubview:introduceBtn];
    //蝴蝶3
    _fly3 = [[GIFImageView alloc] initWithFrame:CGRectMake1(204, 921, 63, 44)];
    [_scrollView addSubview:_fly3];
    _fly3.gifPath = [[NSBundle mainBundle] pathForResource:@"butterfly" ofType:@"gif"];
    [_fly3 startGIF];
    
    //荷花
    ImageContentView *Lotus = [[ImageContentView alloc] initWithFrame:CGRectMake1(16, 956, 176, 236) image:[UIImage imageNamed:@"Lotus"]];
    Lotus.tag  = 102;
    _myView1 = [[UIView alloc] initWithFrame:CGRectMake1(63, 900, 90, 150)];
    _myView1.backgroundColor = [UIColor cyanColor];
    UITextView *textView1 = [[UITextView alloc] initWithFrame:_myView1.bounds];
    [_myView1 addSubview:textView1];
    textView1.editable = NO;
    textView1.text = @"荷花（Lotus flower）：属睡莲目莲科，是莲属二种植物的通称。又名莲花、水芙蓉等。是莲属多年生水生草本花卉。地下茎长而肥厚，有长节，叶盾圆形。花期6至9月，单生于花梗顶端，花瓣多数，嵌生在花托穴内，有红、粉红、白、紫等色，或有彩纹、镶边。坚果椭圆形，种子卵形。";
    textView1.font = [UIFont systemFontOfSize:12];
    textView1.directionalLockEnabled = NO;
    textView1.backgroundColor = [UIColor clearColor];
    
    [_scrollView addSubview:_myView1];
    _myView1.hidden = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animatetion:)];
    [Lotus addGestureRecognizer:tap1];
    [_scrollView addSubview:Lotus];
    
    
    //馆藏精品按钮
    UIButton *collectionBtn = [UIButton initWithFrame:CGRectMake1(254, 970, 28, 87) type:UIButtonTypeCustom backgroundImage:[UIImage imageNamed:@"CollectionBtn"] target:self action:@selector(pushAction) tag:0];
    [_scrollView addSubview:collectionBtn];
    
    //文物
    ImageContentView *CulturalRelic = [[ImageContentView alloc] initWithFrame:CGRectMake1(180, 1097, 87, 115) image:[UIImage imageNamed:@"CulturalRelic"]];
    CulturalRelic.isFaster = YES;
    [_scrollView addSubview:CulturalRelic];
    
    //导览服务按钮
    UIButton *GuideBtn = [UIButton initWithFrame:CGRectMake1(60, 1290, 28, 87) type:UIButtonTypeCustom backgroundImage:[UIImage imageNamed:@"GuideBtn"] target:self action:@selector(pushAction) tag:0];
    [_scrollView addSubview:GuideBtn];
    
    //竹子
    _Bamboo = [[ImageContentView alloc] initWithFrame:CGRectMake1(123, 1267, 182, 296) image:[UIImage imageNamed:@"Bamboo"]];
    [_scrollView addSubview:_Bamboo];
    
    //云船
    UIImageView *CloudBoat = [[UIImageView alloc] initWithFrame:CGRectMake1(16, 1522, 103, 92) image:[UIImage imageNamed:@"CloudBoat"]];
    [_scrollView addSubview:CloudBoat];
    
    //船
    ImageContentView *Boat = [[ImageContentView alloc] initWithFrame:CGRectMake1(36, 1445, 200, 139) image:[UIImage imageNamed:@"Boat"]];
    Boat.isFaster = YES;
    [_scrollView addSubview:Boat];
    
    //参观攻略按钮
    UIButton *VisitBtn = [UIButton initWithFrame:CGRectMake1(248, 1697, 28, 87) type:UIButtonTypeCustom backgroundImage:[UIImage imageNamed:@"VisitBtn"] target:self action:@selector(pushAction) tag:0];
    [_scrollView addSubview:VisitBtn];
    
    //梅花PlumFlower
    _PlumFlower = [[ImageContentView alloc] initWithFrame:CGRectMake1(16, 1624, 201, 223) image:[UIImage imageNamed:@"PlumFlower"]];
    [_scrollView addSubview:_PlumFlower];
    
    //画轴
    ImageContentView *Painting = [[ImageContentView alloc] initWithFrame:CGRectMake1(108, 1813, 133, 123) image:[UIImage imageNamed:@"Painting"]];
    Painting.isFaster = YES;
    [_scrollView addSubview:Painting];
    
    
}

- (void)animatetion:(UITapGestureRecognizer *)sender
{
    ImageContentView *view1 = (ImageContentView *)sender.view;
    NSInteger i = view1.tag;
//    LOG(@"tap----%ld",(long)i);
    switch (i)
    {
        case 101:
        {
            //创建CATransition对象
            CATransition *animation = [CATransition animation];
            
            //设置运动时间
            animation.duration = 5;
            
            //设置运动type
            animation.type = kCATransitionFade;
            
            //设置子类
            animation.subtype = kCATransitionFromLeft;
            
            //设置运动速度
            animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
            if (_myView.hidden) {
                
                _myView.hidden = NO;
                [_myView.layer addAnimation:animation forKey:@"animation"];
            }else
            {
                _myView.hidden = YES;
            }
            

        }
            break;
            /*  动画效果
             kCATransitionFade     淡化效果
             kCATransitionPush     Push效果
             kCATransitionReveal   揭开效果
             kCATransitionMoveIn   覆盖效果
             @"cube"               3D立方效果
             @"suckEffect"         吮吸效果
             @"oglFlip"            翻转效果
             @"rippleEffect"       波纹效果
             @"pageCurl"           翻页效果
             @"pageUnCurl"         反翻页效果
             @"cameraIrisHollowOpen" 开镜头效果
             @"cameraIrisHollowClose"关镜头效果
             */
        case 102:
        {
            //创建CATransition对象
            CATransition *animation = [CATransition animation];
            
            //设置运动时间
            animation.duration = 3;
            
            //设置运动type
            animation.type = kCATransitionMoveIn;
            
            //设置子类
            animation.subtype = kCATransitionFromLeft;
            
            
            //设置运动速度
            animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
            if (_myView1.hidden) {
                
                _myView1.hidden = NO;
                [_myView1.layer addAnimation:animation forKey:@"animation"];
            }else
            {
                _myView1.hidden = YES;
            }
            
        }
            break;
            
        default:
            break;
    }
//    //创建CATransition对象
//    CATransition *animation = [CATransition animation];
//    
//    //设置运动时间
//    animation.duration = 5;
//    
//    //设置运动type
//    animation.type = kCATransitionFade;
//    
//    //设置子类
//    animation.subtype = kCATransitionFromLeft;
//    
//    
//    //设置运动速度
//    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//    if (_myView.hidden) {
//        
//        _myView.hidden = NO;
//        [_myView.layer addAnimation:animation forKey:@"animation"];
//    }else
//    {
//        _myView.hidden = YES;
//    }
//
//    
    
}

- (void)addEmitterAnimations
{
    //樱花花瓣
    CAEmitterLayer *leavesEmitter = [CAEmitterLayer layer];
    //粒子发射位置
    leavesEmitter.emitterPosition = _Cherry.center;
    //发射源的尺寸
    leavesEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 0.0);
    //发射源的形状
    
    /*
     kCAEmitterLayerPoint       中心点
     kCAEmitterLayerLine        线型
     kCAEmitterLayerRectangle   矩形
     kCAEmitterLayerCuboid      长方体
     kCAEmitterLayerCircle      圆
     kCAEmitterLayerSphere      球面
     */
    
    leavesEmitter.emitterShape = kCAEmitterLayerSphere;
    //随机粒子的大小
    CAEmitterCell *leavesflake = [CAEmitterCell emitterCell];
    leavesflake.scale = 0.2;
    leavesflake.scaleRange = 0.5;
    //粒子参数的速度乘数因子
    leavesflake.birthRate = 1.0;
    //生命周期
    leavesflake.lifetime = 25.0;
    //粒子速度
    leavesflake.velocity = 10;
    leavesflake.velocityRange = 10;
    //粒子y方向的加速度分量
    leavesflake.yAcceleration = 2;
    //周围发射角度
    leavesflake.emissionRange = 0.5 * M_PI;
    //自动旋转
    leavesflake.spinRange = 0.25 * M_PI;
    
    leavesflake.contents = (id)[[UIImage imageNamed:@"CherryPetals"] CGImage];
    
    leavesEmitter.shadowOpacity = 1.0;
    leavesEmitter.shadowRadius = 0.0;
    leavesEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    leavesEmitter.shadowColor = [[UIColor whiteColor] CGColor];
    
    leavesEmitter.emitterCells = [NSArray arrayWithObject:leavesflake];
    [_scrollView.layer addSublayer:leavesEmitter];
    
    //竹叶
    
    CAEmitterLayer *leavesEmitter1 = [CAEmitterLayer layer];
    //粒子发射位置
    leavesEmitter1.emitterPosition = _Bamboo.center;
    //发射源的尺寸
    leavesEmitter1.emitterSize = CGSizeMake(self.view.bounds.size.width/2.0 , 0.0);
    leavesEmitter1.emitterShape = kCAEmitterLayerRectangle;
    //随机粒子的大小
    CAEmitterCell *leavesflake1 = [CAEmitterCell emitterCell];
    leavesflake1.scale = 0.2;
    leavesflake1.scaleRange = 0.5;
    //粒子参数的速度乘数因子
    leavesflake1.birthRate = 0.6;
    //生命周期
    leavesflake1.lifetime = 20.0;
    //粒子速度
    leavesflake1.velocity = 10;
    leavesflake1.velocityRange = 5;
    //粒子y方向的加速度分量
    leavesflake1.yAcceleration = 5;
    //周围发射角度
    leavesflake1.emissionRange = 0.5 * M_PI;
    //自动旋转
    leavesflake1.spinRange = 0.25 * M_PI;
    
    leavesflake1.contents = (id)[[UIImage imageNamed:@"BambooLeaves"] CGImage];
    leavesEmitter1.shadowOpacity = 1.0;
    leavesEmitter1.shadowRadius = 0.0;
    leavesEmitter1.shadowOffset  = CGSizeMake(0.0, 1.0);
    leavesEmitter1.shadowColor = [[UIColor whiteColor] CGColor];
    
    leavesEmitter1.emitterCells = [NSArray arrayWithObject:leavesflake1];
    [_scrollView.layer addSublayer:leavesEmitter1];
    
    //梅花
    CAEmitterLayer *leavesEmitter2 = [CAEmitterLayer layer];
    //粒子发射位置
    leavesEmitter2.emitterPosition = _PlumFlower.center;
    //发射源的尺寸
    leavesEmitter2.emitterSize = CGSizeMake(self.view.bounds.size.width/2.0 , 0.0);
    leavesEmitter2.emitterShape = kCAEmitterLayerRectangle;
    //随机粒子的大小
    CAEmitterCell *leavesflake2 = [CAEmitterCell emitterCell];
    leavesflake2.scale = 0.2;
    leavesflake2.scaleRange = 0.5;
    //粒子参数的速度乘数因子
    leavesflake2.birthRate = 1.0;
    //生命周期
    leavesflake2.lifetime = 20.0;
    //粒子速度
    leavesflake2.velocity = 10;
    leavesflake2.velocityRange = 5;
    //粒子y方向的加速度分量
    leavesflake2.yAcceleration = 5;
    //周围发射角度
    leavesflake2.emissionRange = 0.5 * M_PI;
    //自动旋转
    leavesflake2.spinRange = 0.25 * M_PI;
    
    leavesflake2.contents = (id)[[UIImage imageNamed:@"PlumPetals"] CGImage];
    leavesEmitter2.shadowOpacity = 1.0;
    leavesEmitter2.shadowRadius = 0.0;
    leavesEmitter2.shadowOffset  = CGSizeMake(0.0, 1.0);
    leavesEmitter2.shadowColor = [[UIColor whiteColor] CGColor];
    
    leavesEmitter2.emitterCells = [NSArray arrayWithObject:leavesflake2];
    [_scrollView.layer addSublayer:leavesEmitter2];
    

}

#pragma mark -------UIScrollViewDelegate-----------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:0];

    for (ImageContentView *subview in self.scrollView.subviews)
    {
        if ([subview isKindOfClass:[ImageContentView class]] && subview.isFaster)
        {
            [array addObject:subview];
            
        }else if ([subview isKindOfClass:[ImageContentView class]] && !subview.isFaster)
        {
            [array1 addObject:subview];
        }
    }
    for (GIFImageView *subview in self.scrollView.subviews)
    {
        if ([subview isKindOfClass:[GIFImageView class]])
        {
            [array addObject:subview];
        }
    }
    

    [array enumerateObjectsUsingBlock:^(ImageContentView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj imageOffset];
        
    }];
    
    [array1 enumerateObjectsUsingBlock:^(ImageContentView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj imageOffset1];
        
    }];
    
}

CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)

{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    CGRect rect;
    
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    
//  NSLog(@"##########:%f",myDelegate.autoSizeScaleX);
    
    return rect;
    
}


/*
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
        NSLog(@"Begin  Dragging");
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
     NSLog(@"End  Dragging,%f",targetContentOffset->y);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"**Begin  Decelerating");
}// called on finger up as we are moving
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"**End  Decelerating");
}// called when scroll view grinds to a halt

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
     NSLog(@"**End  ScrollingAnimation");
}

*/

- (void)dealloc
{
    _scrollView = nil;
    _myView = nil;
    _myView1 = nil;
    _Cherry = nil;
    _Bamboo = nil;
    _PlumFlower = nil;
    _fly1 = nil;
    _fly2 = nil;
    _fly3 = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

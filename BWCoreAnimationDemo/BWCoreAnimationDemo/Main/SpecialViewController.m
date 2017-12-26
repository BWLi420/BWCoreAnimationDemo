//
//  SpecialViewController.m
//  BWCoreAnimationDemo
//
//  Created by 李勃文 on 2017/12/23.
//  Copyright © 2017年 mortal. All rights reserved.
//

#import "SpecialViewController.h"

@interface SpecialViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self shapeLayer];
    
//    [self textLayer];
    
//    [self transformLayer];
    
//    [self gradientLayer];
    
//    [self replicatorLayer];
    
//    [self scrollLayer];
    
//    [self emitterLayer];
}

#pragma mark - CAShapeLayer
- (void)shapeLayer {
    
    //只会绘制自定义的图形
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(60, 35)];
    [path addArcWithCenter:CGPointMake(35, 35) radius:25 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [path moveToPoint:CGPointMake(5, 70)];
    [path addLineToPoint:CGPointMake(65, 70)];
    [path moveToPoint:CGPointMake(35, 60)];
    [path addLineToPoint:CGPointMake(35, 150)];
    
    //直接绘制圆角矩形
//    UIBezierPath *p2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 20, 50, 100) cornerRadius:10];
    
    //绘制单侧圆角
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerBottomRight;
    UIBezierPath *p3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 20, 50, 100) byRoundingCorners:corner cornerRadii:CGSizeMake(10, 5)];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineWidth = 3.0;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = p3.CGPath;
    
    [self.contentView.layer addSublayer:shapeLayer];
    
    
    //动画
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 20, 10, 10);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    
    //CABasicAnimation
    CABasicAnimation *basicAni = [CABasicAnimation animation];
    basicAni.keyPath = @"backgroundColor";
    basicAni.toValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    
    //帧动画
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animation];
    keyAni.path = p3.CGPath;
    keyAni.keyPath = @"position";
    keyAni.rotationMode = kCAAnimationRotateAuto;//动画模式
//    keyAni.repeatCount = 3;//次数
    
    //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[basicAni, keyAni];
    group.duration = 5.0;
    group.repeatCount = 3;
//    group.repeatDuration = 2.0;
//    group.autoreverses = YES;//自动回放
    
//    group.beginTime;//延时时间
//    group.timeOffset;//起始动画开始时间
//    group.speed;//动画速度
//    group.fillMode = kCAFillModeForwards;
    
    //动画缓冲
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [layer addAnimation:group forKey:@"group"];
    [self.contentView.layer addSublayer:layer];
    
    //移除动画
//    [layer removeAllAnimations];//1.
//    [layer removeAnimationForKey:@"group"];//2.
    
    
    //过渡动画 (动画执行不能放在 viewDidLoad 中)
    self.imgView.image = [UIImage imageNamed:@"img1"];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self.contentView addGestureRecognizer:pan];
}

- (void)panGes:(UIPanGestureRecognizer *)ges {
    
    //过渡动画
    
    // 1.
//    CATransition *trans = [CATransition animation];
//    trans.type = kCATransitionMoveIn;
//    trans.subtype = kCATransitionFromRight;
//    [self.imgView.layer addAnimation:trans forKey:nil];
//
    
    // 2.
//    [UIView transitionWithView:self.imgView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//
//        self.imgView.image = [UIImage imageNamed:@"Snow"];
//    } completion:^(BOOL finished) {
//
//        NSLog(@"%d", finished);
//    }];
    
    // 3.
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [UIView animateWithDuration:2.0 animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        imageView.transform = transform;
        imageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [imageView removeFromSuperview];
        NSLog(@"%d", finished);
    }];
}

#pragma mark - CATextLayer
- (void)textLayer {
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor redColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    
    //choose some text
    NSString *text = @"阿哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈阿哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    textLayer.string = text;
}

#pragma mark - CATransformLayer
- (void)transformLayer {
    
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500;
    self.contentView.layer.sublayerTransform = pt;
    
    //set up the transform for cube 1 and add it
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    c1t = CATransform3DRotate(c1t, M_PI_4, 1, 0, 0);
    c1t = CATransform3DRotate(c1t, -M_PI_4, 0, 1, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.contentView.layer addSublayer:cube1];
    
    //set up the transform for cube 2 and add it
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.contentView.layer addSublayer:cube2];
}

- (CATransformLayer *)cubeWithTransform:(CATransform3D)transform {
    
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    cube.position = CGPointMake(self.contentView.bounds.size.width * 0.5, self.contentView.bounds.size.height * 0.5);
    cube.transform = transform;
    
    return cube;
}

- (CALayer *)faceWithTransform:(CATransform3D)transform {
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(-50, -50, 100, 100);
    
    CGFloat red = rand() / (double)INT_MAX;
    CGFloat green = rand() / (double)INT_MAX;
    CGFloat blue = rand() / (double)INT_MAX;
    
    layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    layer.transform = transform;
    
    return layer;
}

#pragma mark - CAGradientLayer 绘制颜色平滑渐变
- (void)gradientLayer {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:gradientLayer];
    
    //基本渐变
//    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor redColor].CGColor];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //多重渐变
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.1, @0.5, @0.7];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

#pragma mark - CAReplicatorLayer 重复图层
//“高效生成许多相似的图层，它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换”
- (void)replicatorLayer {
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceCount = 10;//重复的个数
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 50, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -50, 0);
    replicatorLayer.instanceTransform = transform;
    
    replicatorLayer.instanceGreenOffset = -0.1;//逐步减少绿色通道
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(75, 75, 50, 50);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    [replicatorLayer addSublayer:layer];
    
/**
    //反射效果
    // 继承 ReflectionView 的view会自动实现反射效果
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:repLayer];
    
    repLayer.instanceCount = 2;
    
    CATransform3D tf = CATransform3DIdentity;
    tf = CATransform3DTranslate(tf, 0, layer.bounds.size.height + 5, 0);
    tf = CATransform3DScale(tf, 1, -1, 0);
    repLayer.instanceTransform = tf;
    repLayer.instanceAlphaOffset = -0.6;
    
    [repLayer addSublayer:layer];
 */
}

#pragma mark - CAScrollLayer
- (void)scrollLayer {
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"img1"].CGImage);
    self.contentView.layer.transform = CATransform3DMakeScale(2, 2, 0);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.contentView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)ges {
    
    CGPoint offset = self.contentView.bounds.origin;
    offset.x -= [ges translationInView:self.contentView].x;
    offset.y -= [ges translationInView:self.contentView].y;
    
    //scroll the layer
    [(CAScrollLayer *)self.contentView.layer scrollToPoint:offset];
    
    //reset the pan gesture translation
    [ges setTranslation:CGPointZero inView:self.contentView];
    
    // scrollPoint:方法从图层树中查找并找到第一个可用的CAScrollLayer，然后滑动它使得指定点成为可视的
    // scrollRectToVisible:方法实现了同样的事情只不过是作用在一个矩形上的
    // visibleRect:属性决定图层（如果存在的话）的哪部分是当前的可视区域
}

#pragma mark - CATiledLayer 切割绘制大图
- (void)tiledLayer {
    
    // imageNamed: 或 imageWithContentsOfFile: 对于超大图可能会造成阻塞主线程
    
}

#pragma mark - CAEmitterLayer 高性能的粒子引擎
- (void)emitterLayer {
    
    // 一个 CAEmitterCell 类似于一个 CALayer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.bounds.size.width * 0.5, emitter.bounds.size.height * 0.5);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Snow"].CGImage);
    cell.birthRate = 100;//粒子个数
    cell.lifetime = 5.0;//粒子消失时间
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;//指定一个可以混合图片内容颜色的混合色
    cell.alphaSpeed = -0.2;//透明度每秒变化量
    cell.velocity = 50;//初始移动速度
    cell.velocityRange = 100;//初始移动范围
    cell.emissionRange = M_PI * 2;//可以从360度任意位置反射出来
    
    emitter.emitterCells = @[cell];
}

@end

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
@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self shapeLayer];
    
//    [self textLayer];
    
    [self transformLayer];
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

@end

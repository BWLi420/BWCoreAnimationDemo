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
    
    [self textLayer];
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

@end

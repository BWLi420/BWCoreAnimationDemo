//
//  MainViewController.m
//  BWCoreAnimationDemo
//
//  Created by 李勃文 on 2017/12/19.
//  Copyright © 2017年 mortal. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (strong, nonatomic) CALayer *blueLayer;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBlueSubLayer];
}

- (void)createBlueSubLayer {
    
    CALayer *blueLayer = [CALayer layer];
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    self.blueLayer = blueLayer;
    
    //相当于UIImageView 的 contentMode
    blueLayer.contentsGravity = kCAGravityResizeAspect;
    blueLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"img1"].CGImage);
    
    
    //相当于 clipsToBounds
    blueLayer.masksToBounds = YES;
    
    blueLayer.contentsRect = CGRectMake(0.5, 0.5, 0.5, 0.5);
    
    blueLayer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
    
    //变形中的中心锚点 默认 0.5, 0.5
    blueLayer.anchorPoint = CGPointMake(0.5, 0.9);
    
    [self.layerView.layer addSublayer:blueLayer];
    
    //调整layer的层级
    //“可以改变屏幕上图层的顺序，但不能改变事件传递的顺序。”
    //    self.layerView.layer.zPosition = 1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // hitTest 如果点在图层上则返回图层，否则返回nil
    CALayer *layer = [self.layerView.layer hitTest:point];
    if (layer == self.layerView.layer) {
        NSLog(@"点击了底层2");
    } else if (layer == self.blueLayer) {
        NSLog(@"点击自定义图层2");
    } else {
        NSLog(@"点在外部2");
    }
    
    // containsPoint 判断点是否在图层frame中
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.layerView.layer containsPoint:point]) {
        NSLog(@"点击了底层1");
    } else {
        
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if ([self.blueLayer containsPoint:point]) {
            NSLog(@"点击自定义图层1");
        } else {
            NSLog(@"点在外部1");
        }
    }
}

@end

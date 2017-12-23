//
//  TransViewController.m
//  BWCoreAnimationDemo
//
//  Created by 李勃文 on 2017/12/23.
//  Copyright © 2017年 mortal. All rights reserved.
//

#import "TransViewController.h"

@interface TransViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@end

@implementation TransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"img1"].CGImage);
    [self transOperation];
}

- (void)transOperation {
    
    // 2D
    
    // 只做一次变换
    //平移
    self.redView.transform = CGAffineTransformMakeTranslation(20, -30);
    self.redView.layer.affineTransform = CGAffineTransformMakeTranslation(20, -30);
    
    //旋转
    self.redView.transform = CGAffineTransformMakeRotation(M_PI_4);
    self.redView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI_4);
    
    //缩放
    self.redView.transform = CGAffineTransformMakeScale(0.5, 1.5);
    self.redView.layer.affineTransform = CGAffineTransformMakeScale(0.5, 1.5);
    
    //在上一次的基础上连续变换
    // layer 下同理
    self.redView.transform = CGAffineTransformTranslate(self.redView.transform, 20, -30);
    
    self.redView.transform = CGAffineTransformRotate(self.redView.transform, M_PI_4);
    
    self.redView.transform = CGAffineTransformScale(self.redView.transform, 0.5, 1.5);
    
    
    // 3D
    //Y轴旋转
    self.blueView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    
    // 通过更改 m34 的值来达到透视投影
    // m34 = -1.0 / d; 距离d一般为500～1000之间即可，减小距离增强透视效果
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = -1.0 / 500;
    transfrom = CATransform3DMakeRotation(M_PI * 0.4, 0, 1, 0);
    self.blueView.layer.transform = transfrom;
    
    //是否绘制背面 doubleSided，默认绘制
    //默认情况下绕Y轴旋转180度观察背面时，会发现与正面完全一致，系统绘制背面默认为正面的镜像
    self.blueView.layer.doubleSided = NO;
}

@end

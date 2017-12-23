//
//  MainViewController.m
//  BWCoreAnimationDemo
//
//  Created by 李勃文 on 2017/12/19.
//  Copyright © 2017年 mortal. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (strong, nonatomic) CALayer *blueLayer;
@end

@implementation BaseViewController

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
    
    //圆角
    blueLayer.cornerRadius = 5.0;
    
    //边框宽度及颜色
    //边框绘制在图层边界内且在最上方
    blueLayer.borderWidth = 1.0;
    blueLayer.borderColor = [UIColor orangeColor].CGColor;
    
    //阴影透明度 [0 ~ 1]
    self.layerView.layer.shadowOpacity = 0.5;
    
    self.layerView.layer.shadowColor = [UIColor greenColor].CGColor;
    self.layerView.layer.shadowOffset = CGSizeMake(3, 5); //默认 [0, -3]
    self.layerView.layer.shadowRadius = 10; // 阴影模糊度，默认3，值越大越平滑
    //当对阴影进行裁剪时，若使用 masksToBounds 会将阴影裁剪掉
    //此时可以在底部加一层图层单独做阴影效果，上面的图层单独做裁剪效果
    
    //阴影效果并不由图层边界决定，而是由图层及所属子视图共同决定阴影的形状
    //可使用 shadowPath 自由规划阴影形状
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, nil, CGRectMake(20, 20, self.layerView.frame.size.width, self.layerView.frame.size.height));
    self.layerView.layer.shadowPath = pathRef;
    
    
    //蒙版 mask
    //“如果mask图层比父图层要小，只有在mask图层里面的内容才是它关心的，除此以外的一切都会被隐藏起来。”
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.layerView.bounds;
    maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"img1"].CGImage);
    blueLayer.mask = maskLayer;
    
    //组透明 shouldRasterize
    //设置为yes，系统会将图层及子视图当作一个图片整体进行处理
    self.layerView.layer.shouldRasterize = YES;
    self.layerView.layer.opacity = 0.5; // opacity 相当于 alpha
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

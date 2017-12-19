//
//  ViewController.m
//  BWCoreAnimationDemo
//
//  Created by 李勃文 on 2017/12/19.
//  Copyright © 2017年 mortal. All rights reserved.
//

#import "ViewController.h"

#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)coreBtnClick:(UIButton *)sender {
    
    MainViewController *mainVC = [MainViewController new];
    [self.navigationController pushViewController:mainVC animated:YES];
}

@end

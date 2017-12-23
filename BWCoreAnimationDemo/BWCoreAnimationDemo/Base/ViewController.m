//
//  ViewController.m
//  BWCoreAnimationDemo
//
//  Created by 李勃文 on 2017/12/19.
//  Copyright © 2017年 mortal. All rights reserved.
//

#import "ViewController.h"

#import "BaseViewController.h"
#import "TransViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)baseBtnClick:(UIButton *)sender {
    
    BaseViewController *mainVC = [BaseViewController new];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (IBAction)TransBtnClick:(UIButton *)sender {
    
    TransViewController *transVC = [TransViewController new];
    [self.navigationController pushViewController:transVC animated:YES];
}

@end

//
//  SettingViewController.m
//  BWCoreAnimationDemo
//
//  Created by 李勃文 on 2017/12/26.
//  Copyright © 2017年 mortal. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    if (@available(iOS 11.0, *)) { //类似系统设置效果
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    }
    
//
//    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//
//    }];
//
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(<#selector#>) userInfo:nil repeats:YES];
//
//    CADisplayLink *t3 = [CADisplayLink displayLinkWithTarget:self selector:@selector(<#selector#>)];
//    [t3 addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 5 : (section == 1 ? 8 : 10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end

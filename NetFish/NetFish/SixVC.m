//
//  SixVC.m
//  NetFish
//
//  Created by tieruni on 16/5/7.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "SixVC.h"

@interface SixVC ()
@property (strong,nonatomic) UITableView *tableview6;
@end

@implementation SixVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.view.backgroundColor = [UIColor redColor];
    self.tableview6 = [UITableView new];
    self.tableview6.frame = self.view.bounds;
    self.tableview6.frame = CGRectMake(0, 0, self.view.frame.size.width, UI_SCREEN_H);
    self.tableview6.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_tableview6];
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

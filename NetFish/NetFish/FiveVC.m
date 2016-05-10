//
//  FiveVC.m
//  NetFish
//
//  Created by tieruni on 16/5/7.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "FiveVC.h"

@interface FiveVC ()
@property (strong,nonatomic) UITableView *tableview5;
@end

@implementation FiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.view.backgroundColor = [UIColor redColor];
    self.tableview5 = [UITableView new];
    self.tableview5.frame = self.view.bounds;
    self.tableview5.frame = CGRectMake(0, 0, self.view.frame.size.width, UI_SCREEN_H);
    self.tableview5.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_tableview5];
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

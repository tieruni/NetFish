//
//  SevenVC.m
//  NetFish
//
//  Created by tieruni on 16/5/7.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "SevenVC.h"

@interface SevenVC ()
@property (strong,nonatomic) UITableView *tableview7;
@end

@implementation SevenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.view.backgroundColor = [UIColor redColor];
    self.tableview7 = [UITableView new];
    self.tableview7.frame = self.view.bounds;
    self.tableview7.frame = CGRectMake(0, 0, self.view.frame.size.width, UI_SCREEN_H);
    self.tableview7.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_tableview7];
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

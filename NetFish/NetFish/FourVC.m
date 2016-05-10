//
//  FourVC.m
//  NetFish
//
//  Created by tieruni on 16/5/7.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "FourVC.h"

@interface FourVC ()
@property (strong,nonatomic) UITableView *tableview4;
@end

@implementation FourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.tableview4 = [UITableView new];
    self.tableview4.frame = self.view.bounds;
    self.tableview4.frame = CGRectMake(0, 0, self.view.frame.size.width, UI_SCREEN_H);
    self.tableview4.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_tableview4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

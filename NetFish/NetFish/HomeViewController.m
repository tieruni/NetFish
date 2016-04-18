//
//  HomeViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "HomeViewController.h"
#import "KSGuideManager.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //引导页
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"10" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"12" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"13" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];

    

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
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return 1;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//   HomeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}
- (IBAction)menuAction:(UIBarButtonItem *)sender {
}
@end

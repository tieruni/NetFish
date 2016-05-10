//
//  HomeViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "HomeViewController.h"
#import "KSGuideManager.h"
#import "SlideHeadView.h"
#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"
#import "FourVC.h"
#import "FiveVC.h"
#import "SixVC.h"
#import "SevenVC.h"
#import "FunnyTableViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    //    [self.navigationController.navigationBar  setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    // Do any additional setup after loading the view.
  //引导页
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"10" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]];
//    [paths addObject:[[NSBundle mainBundle] pathForResource:@"12" ofType:@"jpg"]];
//    [paths addObject:[[NSBundle mainBundle] pathForResource:@"13" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];
    
    //---------->>>>>>>>>>>>>>>>>>>
    //---------->>>>>>>>>>>>
    //完成以下步骤即可
    //初始化SlideHeadView，并加进view
    SlideHeadView *slideVC = [[SlideHeadView alloc]init];
    [self.view addSubview:slideVC];
    
    //    初始化子控制器，使用-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle方法
    FirstVC *VC1 = [[FirstVC alloc]init];
    SecondVC *VC2 = [[SecondVC alloc]init];
    ThirdVC *VC3 = [[ThirdVC alloc]init];
    FourVC *VC4 = [[FourVC alloc]init];
    FiveVC *VC5 = [[FiveVC alloc]init];
    SixVC *VC6 = [[SixVC alloc]init];
    SevenVC *VC7 = [[SevenVC alloc]init];
    
    
    NSArray *titleArr = @[@"热门推荐",@"娱乐",@"军事",@"科技",@"星座",@"生活",@"搞笑"];
    slideVC.titlesArr = titleArr;
    
    //
    [slideVC addChildViewController:VC1 title:titleArr[0]];
    [slideVC addChildViewController:VC2 title:titleArr[1]];
    [slideVC addChildViewController:VC3 title:titleArr[2]];
    [slideVC addChildViewController:VC4 title:titleArr[3]];
    [slideVC addChildViewController:VC5 title:titleArr[4]];
    [slideVC addChildViewController:VC6 title:titleArr[5]];
    [slideVC addChildViewController:VC7 title:titleArr[6]];
    
    
    //最后再调用setSlideHeadView  完成
    [slideVC setSlideHeadView];
    //----------------------------------
    
}

//每次页面出现后
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"EnableGesture" object:nil];
    
    
}
//每次页面消失后
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DisableGesture" object:nil];
    
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
//    return 3;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}
- (IBAction)menuAction:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuSwitch" object:nil];
}


@end

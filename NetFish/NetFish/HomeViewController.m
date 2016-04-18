//
//  HomeViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "HomeViewController.h"
#import "KSGuideManager.h"
#import "WJAdvertCircle.h"
@interface HomeViewController ()<WJAdvertClickDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLaunchAdvert];
    // Do any additional setup after loading the view.
  //引导页
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"10" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"12" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"13" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];

    

}
- (void)showLaunchAdvert{
    // 创建adview
    WJAdvertCircle *sss = [[WJAdvertCircle alloc]initWithFrame:CGRectMake(0, 105,self.view.bounds.size.width , self.view.bounds.size.height / 4)];
    
    // 设置代理
    sss.delegate = self;
    
    // 参数一：展示的图片名  参数二:点击图片对应的url  参数三:是否可循环重复滚动  参数四:是否设置定时自动滚动 (要定时自动播放 isRepeat的值也必须是YES)
    [sss showImages:@[@"Image-3",@"Image-1",@"Image-2"] urls:@[@"www.baidu.com",@"www.sina.com.cn",@"www.163.com"] isRepeat:YES isTiming:YES];
    
    // pageControl的颜色设置
    sss.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    sss.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    
    // 添加视图
    [self.view addSubview:sss];

}
// 点击返回的url
- (void)clickWithUrl:(NSString *)url{
    
    NSLog(@"url:%@",url);
    __block UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = [NSString stringWithFormat:@"点击的url是:%@",url];
    lb.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    lb.alpha = 0.0;
    [UIView animateWithDuration:1 animations:^{
        lb.alpha = 1;
    }];
    [self.view addSubview:lb];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 animations:^{
            
            lb.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [lb removeFromSuperview];
            
        }];
        
        
    });
    
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

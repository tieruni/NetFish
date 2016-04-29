//
//  FirstVC.m
//  slideNavDemo
//
//  Created by 冯学杰 on 16/3/31.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "FirstVC.h"
#import "WJAdvertCircle.h"

@interface FirstVC ()<WJAdvertClickDelegate>
@property(strong,nonatomic)NSArray *Arr;
@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableview = [UITableView new];
    self.tableview.frame = self.view.bounds;
    self.tableview.frame = CGRectMake(0, 0, self.view.frame.size.width, UI_SCREEN_H);
    self.tableview.backgroundColor = [UIColor greenColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //-------->>>>>
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //-------->>>>>
    [self.view addSubview:_tableview];
    //--------
    
    
    //----------
    self.VW = [UIView new];
    
    self.VW.frame = self.tableview.bounds;
    
    
    _VW.backgroundColor =[UIColor greenColor];
    [_tableview addSubview:_VW];;
    self.VW.frame = CGRectMake(0, 0, UI_SCREEN_W, 200);
    
    [self showLaunchAdvert];

}
- (void)showLaunchAdvert{
    // 创建adview
    
    WJAdvertCircle *sss = [[WJAdvertCircle alloc]initWithFrame:CGRectMake(0, 0,UI_SCREEN_W , 200)];
    
    // 设置代理
    sss.delegate = self;
    
    // 参数一：展示的图片名  参数二:点击图片对应的url  参数三:是否可循环重复滚动  参数四:是否设置定时自动滚动 (要定时自动播放 isRepeat的值也必须是YES)
    [sss showImages:@[@"Image-3",@"Image-1",@"Image-2"] urls:@[@"www.baidu.com",@"www.sina.com.cn",@"www.163.com"] isRepeat:YES isTiming:YES];
    
    // pageControl的颜色设置
    sss.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    sss.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    
    // 添加视图
    [_VW addSubview:sss];
    
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
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    }
//------
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [self.tableview initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        //        self.dataArray = [NSMutableArray array];
//        [self addAllViews];
//    }
//    return self;
//}
- (void)addAllViews
{
//    self.aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
//    self.aLabel.backgroundColor = [UIColor greenColor];
//    [self.contentView addSubview:self.aLabel];
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 0) style:UITableViewStylePlain];
//    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@testCell];
//    //    [self.contentView addSubview:self.tableView];
}
//-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.frame =self.tableview.bounds;
    cell.frame = CGRectMake(0, 308, UI_SCREEN_W, 100);
    
    return cell;
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

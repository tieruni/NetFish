//
//  FirstVC.m
//  slideNavDemo
//
//  Created by 冯学杰 on 16/3/31.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "FirstVC.h"
#import "WJAdvertCircle.h"
#import "FirstTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DetailViewController.h"
@interface FirstVC ()<WJAdvertClickDelegate,UITableViewDelegate,UITableViewDataSource>{
    UINib *nib;
}
@property(strong,nonatomic)NSMutableArray *objectForShow;
@property (strong,nonatomic) UIView *VW;
@property (strong,nonatomic) UITableView *tableview;

@end
static BOOL nibsRegistered;
@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectForShow = [NSMutableArray new];
    [self requestData];
    
    nibsRegistered = NO;
    NSLog(@"初始化：%d",nibsRegistered);
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, UI_SCREEN_H - 40 - 64)];
    
    
    //------------>>>>>>>>>
    CGSize contentSize = self.tableview.contentSize;
    [self.tableview setContentSize:CGSizeMake(contentSize.width, contentSize.height - 40 - 64)];
    self.tableview.backgroundColor = [UIColor clearColor];

    
    //-------->>>>>
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
//    [self.tableview registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //-------->>>>>
    [self.view addSubview:_tableview];
//    [_tableview release];
    //--------
    
    
    //----------
    self.VW = [UIView new];
    self.VW = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, 200)];
    _VW.backgroundColor =[UIColor greenColor];
    [_tableview addSubview:_VW];
    
    
     _tableview.tableHeaderView = self.VW ;
    [self showLaunchAdvert];

}
- (void)showLaunchAdvert{
    // 创建adview
    
    WJAdvertCircle *sss = [[WJAdvertCircle alloc]initWithFrame:CGRectMake(0, 0,UI_SCREEN_W , 200)];
    
    // 设置代理
    sss.delegate = self;
    
    // 参数一：展示的图片名  参数二:点击图片对应的url  参数三:是否可循环重复滚动  参数四:是否设置定时自动滚动 (要定时自动播放 isRepeat的值也必须是YES)
    [sss showImages:@[@"Image-3",@"Image-1",@"Image-2"] urls:@[@"www.baidu.com",@"www.sina.com.cn",@"www.163.com"] isRepeat:NO isTiming:NO];
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestData{
    [_objectForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"hotnews"];
    
    //让导航条失去交互能力
    self.navigationController.view.userInteractionEnabled = NO;
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //查询语句
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //让导航条恢复交互能力
        self.navigationController.view.userInteractionEnabled = YES;
        //停止菊花动画
        [avi stopAnimating];
        if (!error) {
            
            NSLog(@"objects = %@",objects);
            _objectForShow = [NSMutableArray arrayWithArray:objects];
            
            [_tableview reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
            return ;
        }
    }];
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 10;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _objectForShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"CustomCell";
    if (!nib) {
//        FirstTableViewCell *cell =[[FirstTableViewCell alloc]initWithFrame:CGRectMake(0, 200, UI_SCREEN_W, 110)];
        nib = [UINib nibWithNibName:@"FNNewsSglImgCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identy];
        NSLog(@"我是从nib过来的，%ld",indexPath.row);
    }
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
//    NSUInteger row = [indexPath row];
    
    PFObject *obj = _objectForShow[indexPath.row];
    NSString *title = obj[@"title1"];
    cell.TitleLabel.text = title;
    
    NSString *new = obj[@"news1"];
    cell.TxtLabel.text = new;
    
    PFFile *photofile = obj[@"photo1"];
    NSString *photoUrlStr = photofile.url;
    NSURL *photoUrl = [NSURL URLWithString:photoUrlStr];
    [cell.newsimageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"Image77"]] ;
//    if (row%2 == 0) {
//        cell.TitleLabel.text = @"我是偶数行的";
//        cell.TxtLabel.text = @"我是子标题";
//        cell.newsimageView.image = [UIImage imageNamed:@"Image77"];
//    }else{
//        cell.TitleLabel.text = @"我是奇数行的";
//        cell.TxtLabel.text = @"我是奇数行的子标题";
//        cell.newsimageView.image = [UIImage imageNamed:@"Image66"];
//    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [[self tableView:tableView cellForRowAtIndexPath:indexPath] frame].size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    //获得用户当前所选中的细胞的行数
//    NSIndexPath *indexPath = _tableview.indexPathForSelectedRow;
    //根据上述行数获取该行所对应的数据
    PFObject *newDetail = _objectForShow [indexPath.row];
    //获得将要跳转到的页面的实例
    UINavigationController *mineVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"DetailNav"];
    //将需要传递给下一页的数据放入下一页准备好接数据的容器中
    
    
    DetailViewController *detailViewController =[[DetailViewController alloc]initWithNibName:@"UINavigationController" bundle:nil];
    detailViewController.Detailnew = newDetail;
    NSLog(@"------>>>detailViewController.Detailnew = %@",detailViewController.Detailnew);
    
    
    [self.navigationController presentViewController:mineVC animated:YES completion:nil];
    return;
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}
*/

@end

//
//  FiveVC.m
//  NetFish
//
//  Created by tieruni on 16/5/7.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "FiveVC.h"
#import "DetailViewController.h"
#import "FiveTableViewCell.h"
@interface FiveVC ()<UITableViewDataSource,UITableViewDelegate,WHC_PullRefreshDelegate>{
    UINib *nib;
}
@property (nonatomic , assign)WHCPullRefreshStyle refreshStyle;
@property (strong,nonatomic) UITableView *tableviewConstellation;
@property(strong,nonatomic)NSMutableArray *objectForShowConstellation;


@end

@implementation FiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestConstellationData];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableviewConstellation = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, UI_SCREEN_H - 40 - 64)];
    
    
    UIView *refrashView = [UIView new];
//    refrashView.backgroundColor = [UIColor lightGrayColor];
    _tableviewConstellation.tableFooterView = refrashView;
    [_tableviewConstellation setWHCRefreshStyle:_refreshStyle delegate:self];
    
    CGSize contentSize = self.tableviewConstellation.contentSize;
    [self.tableviewConstellation setContentSize:CGSizeMake(contentSize.width, contentSize.height - 40 - 64)];
    self.tableviewConstellation.backgroundColor = [UIColor whiteColor];
    self.tableviewConstellation.delegate = self;
    self.tableviewConstellation.dataSource = self;
    [self.view addSubview:_tableviewConstellation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
#pragma mark - WHC_PullRefreshDelegate

- (void)WHCUpPullRequest{
    NSLog(@"开始加载更多");
    //    _count+= 3;
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_tableviewConstellation reloadData];
        [_tableviewConstellation WHCDidCompletedWithRefreshIsDownPull:YES];
    });
}
- (void)WHCDownPullRequest{
    NSLog(@"上拉刷新");
    double delayInSeconds = 3.0;
    //    _count+= 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_tableviewConstellation reloadData];
        [_tableviewConstellation WHCDidCompletedWithRefreshIsDownPull:YES];
    });
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(void)requestConstellationData{
    [_objectForShowConstellation removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"constellationnews"];
    
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
            _objectForShowConstellation = [NSMutableArray arrayWithArray:objects];
            
            [_tableviewConstellation reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
            return ;
        }
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _objectForShowConstellation.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"CustomCell5";
    if (!nib) {
        //        FirstTableViewCell *cell =[[FirstTableViewCell alloc]initWithFrame:CGRectMake(0, 200, UI_SCREEN_W, 110)];
        nib = [UINib nibWithNibName:@"FiveVCCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identy];
        NSLog(@"我是从nib过来的，%ld",indexPath.row);
    }
    FiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    //    NSUInteger row = [indexPath row];
    
    PFObject *obj = _objectForShowConstellation[indexPath.row];
    NSString *title = obj[@"title5"];
    cell.FiveVCConstellationTitle.text = title;
    
    NSString *new = obj[@"news5"];
    cell.FiveVCConstellationTxtLab.text = new;
    
    PFFile *photofile = obj[@"photo5"];
    NSString *photoUrlStr = photofile.url;
    NSURL *photoUrl = [NSURL URLWithString:photoUrlStr];
    [cell.FiveVCConstellationImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"Image77"]] ;
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
    PFObject *newDetail = _objectForShowConstellation [indexPath.row];
    
    
    
    //将需要传递给下一页的数据放入下一页准备好接数据的容器中
    NewDetailViewController *newdetailViewController = [Utilities getStoryboardInstance:@"Main" byIdentity:@"NewsDetail"];
    
    
    newdetailViewController.Detailnew = newDetail;
    NSLog(@"------>>>detailViewController.Detailnew = %@",newdetailViewController.Detailnew);
    
    //获得将要跳转到的页面的实例
    UINavigationController *mineVC = [[UINavigationController alloc] initWithRootViewController:newdetailViewController];
    
    [self presentViewController:mineVC animated:YES completion:nil];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

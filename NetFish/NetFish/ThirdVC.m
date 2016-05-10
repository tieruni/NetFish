//
//  ThirdVC.m
//  NetFish
//
//  Created by tieruni on 16/5/7.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "ThirdVC.h"
#import <UIImageView+WebCache.h>
#import "ThirdTableViewCell.h"
#import "DetailViewController.h"
@interface ThirdVC ()<UITableViewDataSource,UITableViewDelegate>{
    UINib *nib;
}
@property(strong,nonatomic)NSMutableArray *objectForShowMily;
@property (strong,nonatomic) UITableView *tableviewMily;

@property (strong,nonatomic) UIImageView *IMW3;
@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestMilyData];
    // Do any additional setup after loading the view.
    //给SecondVC添加tableview
    self.view.backgroundColor = [UIColor redColor];
    self.tableviewMily = [UITableView new];
    self.tableviewMily.frame = self.view.bounds;
    self.tableviewMily.frame = CGRectMake(0, 0, UI_SCREEN_W, UI_SCREEN_H - 40 - 64);
    CGSize contentSize = self.tableviewMily.contentSize;
    [self.tableviewMily setContentSize:CGSizeMake(contentSize.width, contentSize.height - 40 - 64)];
    self.tableviewMily.backgroundColor = [UIColor whiteColor];
    self.tableviewMily.delegate = self;
    self.tableviewMily.dataSource = self;
    
    [self.view addSubview:_tableviewMily];
    
    
    //给tableview2添加headerview
    self.IMW3 = [UIImageView new];
    self.IMW3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, 200)];
    _IMW3.backgroundColor =[UIColor redColor];
    _IMW3.image = [UIImage imageNamed:@"Image66"];
    [_tableviewMily addSubview:_IMW3];
    //将图片视图塞进headerview
    _tableviewMily.tableHeaderView = self.IMW3 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestMilyData{
    [_objectForShowMily removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"militarynews"];
    
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
            _objectForShowMily = [NSMutableArray arrayWithArray:objects];
            
            [_tableviewMily reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
            return ;
        }
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _objectForShowMily.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identy = @"CustomCell3";
    if (!nib) {
        //        FirstTableViewCell *cell =[[FirstTableViewCell alloc]initWithFrame:CGRectMake(0, 200, UI_SCREEN_W, 110)];
        nib = [UINib nibWithNibName:@"FNReadListSglImgCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identy];
        NSLog(@"我是从nib过来的，%ld",indexPath.row);
    }
    ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    //    NSUInteger row = [indexPath row];
    
    PFObject *obj = _objectForShowMily[indexPath.row];
    NSString *title = obj[@"title3"];
    cell.MilyNewsTitleLab.text = title;
    
        NSString *new = obj[@"news3"];
        cell.MilyNewsTxtLab.text = new;
    
    PFFile *photofile = obj[@"photo3"];
    NSString *photoUrlStr = photofile.url;
    NSURL *photoUrl = [NSURL URLWithString:photoUrlStr];
    [cell.MilyNewsImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"Image77"]] ;
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
    PFObject *newDetail = _objectForShowMily [indexPath.row];
    //获得将要跳转到的页面的实例
    UINavigationController *mineVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"DetailNav"];
    //将需要传递给下一页的数据放入下一页准备好接数据的容器中
    
    
    DetailViewController *detailViewController =[[DetailViewController alloc]initWithNibName:@"UINavigationController" bundle:nil];
    detailViewController.Detailnew = newDetail;
    NSLog(@"------>>>detailViewController.Detailnew = %@",detailViewController.Detailnew);
    
    
    [self.navigationController presentViewController:mineVC animated:YES completion:nil];
    return;
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

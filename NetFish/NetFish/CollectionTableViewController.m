//
//  CollectionTableViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "UITableView+Wave.h"
#import "SWTableViewCell.h"
#import "UIScrollView+WHC_PullRefresh.h"
#import "CollectionTableViewCell.h"
@interface CollectionTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *whcTV;
@property (strong,nonatomic) NSMutableArray *objectForShow;
@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectForShow = [NSMutableArray new];
    _whcTV.tableFooterView = [[UIView alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //    存放显示在单元格上的数据
    [self requestData];
    
}

- (void)requestData{
    [_objectForShow removeAllObjects];
    PFUser *currentUser = [PFUser currentUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"collectioninfouser = %@",currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Collection" predicate:predicate];
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //先停止菊花动画
        [avi stopAnimating];
        
        [self.tableView reloadDataAnimateWithWave:RightToLeftWaveAnimation];
        
        if (!error) {
            NSLog(@"objects = %@",objects);
            _objectForShow = [NSMutableArray arrayWithArray:objects];
            [_whcTV reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _objectForShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = _objectForShow[indexPath.row];
    NSString *name = obj[@"newstitle"];
    PFFile *photoFile = obj[@"newsphoto"];
    cell.CollectionLabel.text = name;
    
    [photoFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.CollectionImageView.image = image;
        }else {
            NSLog(@"%@",error.userInfo);
        }
    }];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle== (UITableViewCellEditingStyleDelete)) {
        //        获取选中删除行索引值
        NSInteger row = [indexPath row];
        PFObject *obj = _objectForShow[indexPath.row];
        //        通过获取的索引值删除数组中的值
        [self.objectForShow removeObjectAtIndex:row];
        //删除单元格的某一行时，在用动画效果实现删除过程
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //让导航条失去交互能力
        self.navigationController.view.userInteractionEnabled = NO;
        //删除收藏数据
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            //让导航条恢复交互能力
            self.navigationController.view.userInteractionEnabled = YES;
            [aiv stopAnimating];
            
            if (succeeded) {
                [Utilities popUpAlertViewWithMsg:@"删除成功" andTitle:nil onView:self];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [Utilities popUpAlertViewWithMsg:@"网络繁忙，请稍后再试" andTitle:nil onView:self];
            }

        }];
        
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    //获得用户当前所选中的细胞的行数
    //    NSIndexPath *indexPath = _tableview.indexPathForSelectedRow;
    //根据上述行数获取该行所对应的数据
    PFObject *newDetail = _objectForShow [indexPath.row];
    //    NewDetailViewController *newdetailViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"NewsDetail"];
    
    
    //将需要传递给下一页的数据放入下一页准备好接数据的容器中
    DetailViewController *detailViewController = [Utilities getStoryboardInstance:@"Main" byIdentity:@"NewsDetail"];
    
    
    detailViewController.Detailnew = newDetail;
    NSLog(@"------>>>detailViewController.Detailnew = %@",detailViewController.Detailnew);
    
    //获得将要跳转到的页面的实例
    UINavigationController *mineVC = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [self presentViewController:mineVC animated:YES completion:nil];
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end

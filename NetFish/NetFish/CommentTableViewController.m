//
//  CommentTableViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/18.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "publishViewController.h"
@interface CommentTableViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectsForShow = [NSMutableArray new];
    [self refreshData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:@"RefreshComment" object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//数据请求
- (void)refreshData {
        PFUser *currentUser = [PFUser currentUser];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"discussText = %@",currentUser ];
        PFQuery *query = [PFQuery queryWithClassName:@"Discuss" predicate:predicate];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"userinfo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //        [_aiv stopAnimating];
        UIRefreshControl *rc = (UIRefreshControl *)[_tableview viewWithTag:10001];
        [rc endRefreshing];
        if (!error) {
            NSLog(@"objects = %@",objects);
            [_objectsForShow removeAllObjects];
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            [_tableview reloadData];
        }else{
            
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];
    
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _objectsForShow.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     CellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = _objectsForShow[indexPath.row];
    PFUser *user = obj[@"userinfo"];
//    NSString *name = user[@"nickname"];
    NSString *discussText = obj[@"discussText"];
    NSDate *date = obj.createdAt;
    self.navigationItem.title = user[@"name"];
    PFFile *photoFile = user[@"avatar"];
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    [cell.userimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Default"]];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:date];
    cell.time.text = dateString;
    cell.commentLbl.text = discussText;
    return cell;
}


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

- (IBAction)backItem:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)pinglunItem:(UIBarButtonItem *)sender {
    UINavigationController *pinlunVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"A"];
    [self.navigationController pushViewController:pinlunVC animated:YES];
    
}
@end

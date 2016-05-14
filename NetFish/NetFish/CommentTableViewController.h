//
//  CommentTableViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/18.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewController : UITableViewController
//@property (strong, nonatomic) PFObject *discuss;

@property (strong, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)backItem:(UIBarButtonItem *)sender;
- (IBAction)pinglunItem:(UIBarButtonItem *)sender;

@end

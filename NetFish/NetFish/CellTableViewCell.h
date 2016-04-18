//
//  CellTableViewCell.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/18.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *username;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
@property (weak, nonatomic) IBOutlet UIButton *goodtouchu;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

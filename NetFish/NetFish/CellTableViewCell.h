//
//  CellTableViewCell.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *commentTF;
- (IBAction)goodAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *numberLbl;
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;



@end

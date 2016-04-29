//
//  FirstTableViewCell.h
//  NetFish
//
//  Created by tieruni on 16/4/29.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsimage;

@property(strong,nonatomic)IBOutlet UILabel *titlelable;

@property (weak, nonatomic) IBOutlet UILabel *Txtlable;

@end

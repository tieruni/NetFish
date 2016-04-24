//
//  HelpViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/24.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController
- (IBAction)backAction:(UIBarButtonItem *)sender;
- (IBAction)mesAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)aboutAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

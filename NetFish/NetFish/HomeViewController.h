//
//  HomeViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

- (IBAction)menuAction:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *HomeImageView;

- (IBAction)ButtonAction1:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)ButtonAction2:(UIButton *)sender forEvent:(UIEvent *)event;

@end

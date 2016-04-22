//
//  LeftViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *loginLbl;
- (IBAction)imageAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
- (IBAction)collectionAction:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event;




@end

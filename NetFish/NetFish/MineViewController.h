//
//  MineViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController

- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;

@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sex;

- (IBAction)sexAction:(UISegmentedControl *)sender forEvent:(UIEvent *)event;

- (IBAction)confirmAction:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)pickimage:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;







@end

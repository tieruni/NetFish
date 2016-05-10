//
//  SignInViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/16.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController

- (IBAction)backLoginAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confidPW;
- (IBAction)SignInUpAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTF;

@end

//
//  ViewController.h
//  NetFish
//
//  Created by tieruni on 16/4/16.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
//@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)SignInAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)forgetPWAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *singIn;



@end


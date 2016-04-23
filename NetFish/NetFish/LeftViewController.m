//
//  LeftViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()


@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)imageAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *currentUser = [PFUser currentUser];
    //    _usernameLbl.text = currentUser.username;
    NSLog(@"currentUser = %@", currentUser);
    if (currentUser) {
        UINavigationController *mineVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Mine"];
        [self presentViewController:mineVC animated:YES completion:nil];
        
        
        
    }else{
        
        NSLog(@"当前用户没登录");
        UINavigationController *SignVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Sign"];
        [self presentViewController:SignVC animated:YES completion:nil];
        
        
    }
}
- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [PFUser logOutInBackgroundWithBlock:^(NSError * error) {
        if (!error) {
            //
            UINavigationController *SignVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Sign"];
            [self presentViewController:SignVC animated:YES completion:nil];
            
        }else{
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接通畅" andTitle:nil onView:self];
        }
        //
        
        
        
    }];
}

- (IBAction)collectonAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end

//
//  SignInViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/16.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
    

@end

@implementation SignInViewController

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

- (IBAction)backLoginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //设置按钮返还上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (IBAction)SignInUpAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
}
@end

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
    POPSpringAnimation *springForwardAnimation = [POPSpringAnimation animation];
    springForwardAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    springForwardAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.2, 1.2)];
    //设置弹簧的振幅（弹簧来回振动的位移量的大小）
    springForwardAnimation.springBounciness =10;
    //设置弹簧的弹性系数（弹簧来回振动的速度的快慢）
    springForwardAnimation.springSpeed =10;
    
    [_eixtBtn pop_addAnimation:springForwardAnimation forKey:@"springForwardAnimation"];
    
    //设置动画完成以后的回调
    springForwardAnimation.completionBlock = ^(POPAnimation *anim,BOOL finished){
        POPBasicAnimation *basicBackwardAnimation = [POPBasicAnimation animation];
        basicBackwardAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
        basicBackwardAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0,1.0)];
        
        [_eixtBtn pop_addAnimation:basicBackwardAnimation forKey:@"basicBackwardAnimation"];
    };
    
}

- (IBAction)collectonAction:(UIButton *)sender forEvent:(UIEvent *)event {
}





@end

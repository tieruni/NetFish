//
//  DetailViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userTF;
- (IBAction)userAction:(UITextField *)sender forEvent:(UIEvent *)event;

@end

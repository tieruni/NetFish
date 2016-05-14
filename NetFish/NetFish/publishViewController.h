//
//  publishViewController.h
//  NetFish
//
//  Created by fanfan on 16/5/14.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface publishViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *neirong;
- (IBAction)fabiao:(UIBarButtonItem *)sender;

@end

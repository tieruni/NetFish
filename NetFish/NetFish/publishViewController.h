//
//  publishViewController.h
//  NetFish
//
//  Created by fanfan on 16/5/9.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface publishViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
- (IBAction)publishAction:(UIBarButtonItem *)sender;
- (IBAction)cancelAction:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

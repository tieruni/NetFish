//
//  DetailViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *DetailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *DetailImageView;
@property (weak, nonatomic) IBOutlet UITextView *DetailTextView;
@property (weak, nonatomic) IBOutlet UILabel *DetailTimeLab;

@property (strong,nonatomic)NSNumber *num;
@property (strong,nonatomic)PFObject *Detailnew;
@end

//
//  NewDetailViewController.h
//  NetFish
//
//  Created by tieruni on 16/5/14.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *NewDetailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *NewDetailImageView;
@property (weak, nonatomic) IBOutlet UITextView *NewDetailTextView;
@property (strong,nonatomic)PFObject *Detailnew;
@end

//
//  MineViewController.h
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController
<<<<<<< HEAD

- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
=======
- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
>>>>>>> 9ac62b5c83a9bef44d1384f0b0824373908dd247

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *sexTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
<<<<<<< HEAD


=======
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
>>>>>>> 9ac62b5c83a9bef44d1384f0b0824373908dd247
- (IBAction)confirmAction:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)pickimage:(UITapGestureRecognizer *)sender;





<<<<<<< HEAD
=======

>>>>>>> 9ac62b5c83a9bef44d1384f0b0824373908dd247
@end

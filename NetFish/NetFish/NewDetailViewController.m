//
//  NewDetailViewController.m
//  NetFish
//
//  Created by tieruni on 16/5/14.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "NewDetailViewController.h"
#import <UIImageView+WebCache.h>
@interface NewDetailViewController ()

@end

@implementation NewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showDetail];
}
-(void)showDetail{
    
    NSLog(@"Detailnew = %@",_Detailnew);
    NSString *title = _Detailnew[@"title1"];
    _NewDetailTitle.text = title;
    NSString *newTxt = _Detailnew[@"news1"];
    _NewDetailTextView.text = newTxt;
    PFFile *photofile = _Detailnew[@"photo1"];
    NSString *photoUrlStr = photofile.url;
    NSURL *photoUrl = [NSURL URLWithString:photoUrlStr];
    [_NewDetailImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"Image77"]] ;
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

@end

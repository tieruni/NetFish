//
//  DetailViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "DetailViewController.h"
#import <UIImageView+WebCache.h>
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showDetail];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showDetail{
    
    NSLog(@"Detailnew = %@",_Detailnew);
    NSString *title = _Detailnew[@"title1"];
    _DetailTitle.text = title;
    NSString *newTxt = _Detailnew[@"news1"];
    _DetailTextView.text = newTxt;
    PFFile *photofile = _Detailnew[@"photo1"];
    NSString *photoUrlStr = photofile.url;
    NSURL *photoUrl = [NSURL URLWithString:photoUrlStr];
    [_DetailImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"Image77"]] ;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//评论跳转
- (IBAction)pinglunAction:(UIButton *)sender forEvent:(UIEvent *)event {
    UINavigationController *pinlunVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"PINLUN"];
    [self presentViewController:pinlunVC animated:YES completion:nil];

}
@end

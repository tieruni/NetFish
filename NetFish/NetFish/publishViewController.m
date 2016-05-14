//
//  publishViewController.m
//  NetFish
//
//  Created by fanfan on 16/5/14.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "publishViewController.h"
#import "CommentTableViewController.h"
@interface publishViewController ()

@end

@implementation publishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _neirong.backgroundColor = [UIColor lightGrayColor];
    _neirong.delegate = self;
    _label.enabled = NO;
    _label.text = @"我来说两句";
    _label.font =  [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor lightGrayColor];
    //___________________________
   // _wordCountLabel.font = [UIFont systemFontOfSize:14.f];
    //_wordCountLabel.textColor = [UIColor blueColor];
    //self.wordCountLabel.text = @"0/120";
    //self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) textViewDidChange:(UITextView *)textView{
  
    if ([textView.text length] == 0) {
        [_label setHidden:NO];
    }else{
        [_label setHidden:YES];
    }
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/120",(long)wordCount];
    [self wordLimit:textView];
}

#pragma mark textField的字数限制

//在这个地方计算输入的字数
//- (void)textViewDidChange:(UITextView *)textView
//{
//    
//}
#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 120) {
        NSLog(@"%ld",text.text.length);
        self.neirong.editable = YES;
        
    }
    else{
        self.neirong.editable = NO;
        
    }
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fabiao:(UIBarButtonItem *)sender {
    NSString *neirong = _neirong.text;
    if (_neirong.text.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入内容" andTitle:nil onView:self];
        return;
    }
    PFObject *discuss = [PFObject objectWithClassName:@"Discuss"];
    discuss[@"discussText"] = neirong;
    self.tabBarController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [discuss saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        //让选项卡栏控制器恢复交互能力
        self.tabBarController.view.userInteractionEnabled = YES;
        //菊花停转
        [avi stopAnimating];
        if (succeeded) {
            UINavigationController *pinlunVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"C"];
            [self.navigationController pushViewController:pinlunVC animated:YES];
            
        }else{
            [Utilities popUpAlertViewWithMsg:@"当前网络繁忙，亲！请稍后再试" andTitle:nil onView:self];
        }
    }];

}
@end

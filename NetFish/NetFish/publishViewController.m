//
//  publishViewController.m
//  NetFish
//
//  Created by fanfan on 16/5/9.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "publishViewController.h"
#import "CommentTableViewController.h"
@interface publishViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@end

@implementation publishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _objectsForShow = [NSMutableArray new];
    // Do any additional setup after loading the view.
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.delegate = self;
    _label.enabled = NO;
    _label.text = @"我来说两句";
    _label.font =  [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor lightGrayColor];
}
- (void) textViewDidChange:(UITextView *)textView{
  
    if ([textView.text length] == 0) {
        [_label setHidden:NO];
    }else{
        [_label setHidden:YES];
    }
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

- (IBAction)publishAction:(UIBarButtonItem *)sender {
    [_objectsForShow removeAllObjects];
    PFUser *currentUser = [PFUser currentUser];
    NSString *neirong = _textView.text;
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
     [self.navigationController pushViewController:[[CommentTableViewController alloc]init] animated:YES];
}
@end

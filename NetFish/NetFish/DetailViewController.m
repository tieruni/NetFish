//
//  DetailViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "DetailViewController.h"
#import <UIImageView+WebCache.h>
#import "DisperseBtn.h"
#import "HomeViewController.h"
@interface DetailViewController ()
@property (weak, nonatomic) DisperseBtn *disView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏属性
    self.navigationItem.title = @"新闻详情";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    //隐藏导航栏返回按钮
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    //自定义导航栏的返回按钮
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    btn. frame=CGRectMake(15, 5, 38, 38);
    
    //[btn setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>:[UIImage imageNamed:@返回.png] forState:UIControlStateNormal];
//    
//    [btn addTarget:selfaction:@selector(goBackAction)forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem*back=[[UIBarButtonItemalloc]initWithCustomView:btn];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
   
   
    
    
    NSString *str = _num.description;
    //显示详情信息
    if ([str isEqualToString:@"1"]) {
        NSLog(@"str = %@",str);
        [self showDetail1];
    }
    if ([str isEqualToString:@"2"]) {
        NSLog(@"str = %@",str);
        [self showDetail1];
    }
    
    //实例化对象
    DisperseBtn *disView = [[DisperseBtn alloc]init];
    disView.frame = CGRectMake(UI_SCREEN_W *3/4, UI_SCREEN_H *7/8, 50, 50);
    //设置适应的边界
    CGRect frame = CGRectMake(0, 64, UI_SCREEN_W, UI_SCREEN_H-64);
    disView.borderRect = frame;
    //设置两个状态对应的图片
    disView.closeImage = [UIImage imageNamed:@"icon2"];
    disView.openImage = [UIImage imageNamed:@"icon3"];
    [self.view addSubview:disView];
    
    _disView = disView;
    //最多9个弹出按钮
    [self setDisViewButtonsNum:3];
    
}
-(void)showDetail1{
    
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
-(void)showDetail2{
    
    NSLog(@"Detailnew = %@",_Detailnew);
    NSString *title = _Detailnew[@"title2"];
    _DetailTitle.text = title;
    NSString *newTxt = _Detailnew[@"news2"];
    _DetailTextView.text = newTxt;
    PFFile *photofile = _Detailnew[@"photo2"];
    NSString *photoUrlStr = photofile.url;
    NSURL *photoUrl = [NSURL URLWithString:photoUrlStr];
    [_DetailImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"Image77"]] ;
}
//1
- (void)setDisViewButtonsNum:(int)num{
    
    [_disView recoverBotton];
    
    for (UIView *btn in _disView.btns) {
        [btn removeFromSuperview];
    }
    
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i< num; i++) {
        UIButton *btn = [UIButton new];
        NSString *name = [NSString stringWithFormat:@"SC%d",i];
        [btn setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [marr addObject:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonTagget:) forControlEvents:UIControlEventTouchUpInside];
    }
    _disView.btns = [marr copy];
}
//2
-(void)buttonTagget:(UIButton *)sender{
    
    if (sender.tag == 0) {
        NSLog(@"000");
        PFUser *currentUser = [PFUser currentUser];

        NSLog(@"currentUser = %@", currentUser);
        if (currentUser) {
            PFObject *collection = [PFObject objectWithClassName:@"Collection"];
            collection[@"newstitle"] = _DetailTitle.text;
            
            //将一个UIImage对象转换成png格式的数据流
            UIImage *photoImage = _DetailImageView.image;
            NSData *photoData = UIImagePNGRepresentation(photoImage);
            //将上述数据流转换成parse的PFFile对象（PFFile对象是一个文件对象，这里除了要设置文件内容这个数据流以外，还要给文件起一个文件名，文件名可以是任何名字）
            PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
            collection[@"newsphoto"] = photoFile;
            collection[@"collectioninfouser"] = currentUser;
            //保存收藏数据
            UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
            [collection saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                [aiv stopAnimating];
            
                if (succeeded) {
                    [Utilities popUpAlertViewWithMsg:@"保存成功" andTitle:nil onView:self];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    [Utilities popUpAlertViewWithMsg:@"网络繁忙，请稍后再试" andTitle:nil onView:self];
                }

            }];
            
        }else{
            [Utilities popUpAlertViewWithMsg:@"请先登录" andTitle:nil onView:self];
        }
        
    }
    if (sender.tag == 1) {
        NSLog(@"111");
        UINavigationController *pinlunVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"PINLUN"];
        [self presentViewController:pinlunVC animated:YES completion:nil];

    }
    if (sender.tag == 2) {
        NSLog(@"222");
        [self dismissViewControllerAnimated:YES completion:nil];

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


//评论跳转

@end

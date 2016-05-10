//
//  SignInViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/16.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
    

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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

- (IBAction)backLoginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //设置按钮返还上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (IBAction)SignInUpAction:(UIButton *)sender forEvent:(UIEvent *)event {
//    //获得用户输入的信息
    NSString *username = _usernameTF.text;
    NSString *email = _emailTF.text;
    NSString *password = _passwordTF.text;
    NSString *confirmPwd = _confidPW.text;
    NSString *nickname = _nicknameTF.text;
    //判断用户是否输入信息
    if (username.length == 0 || email.length == 0 || password.length == 0 || confirmPwd.length == 0||nickname.length ==0) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil onView:self];
        return;
    }
    if (![password isEqualToString:confirmPwd]) {
        [Utilities popUpAlertViewWithMsg:@"确认密码必须与密码保持一致" andTitle:nil onView:self];
        return;
    }
    /*    //
     PFObject *info = [PFObject objectWithClassName:@"info"];
     //设置初始贪婪币和初始可出售卡数量
     info[@"greedCon"] = @10000;
     info[@"saleLinitation"] = @5;
     */
    //在parse自带的user表中新建一行
    PFUser *user = [PFUser user];
    //设置用户名，邮箱，密码
    user.username = username;
    user.email = email;
    user.password = password;
    user[@"nickname"] = nickname;
    //user[@"info"] = info;
    
    //让导航条失去交互能力
    self.navigationController.view.userInteractionEnabled = NO;
    
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //开始注册
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        //注册后的回调
        //让导航条恢复交互能力
        self.navigationController.view.userInteractionEnabled = YES;
        //先停止菊花动画
        [avi stopAnimating];
        //判断注册是否成功
        if (succeeded) {
            NSLog(@"注册成功");
            //先将SignUpSuccessfully这个在单例化全局变量中的flag删除以保证该flag的唯一性
            [[StorageMgr singletonStorageMgr] removeObjectForKey:@"SignUpSuccessfully"];
            //然后将这个flag设置为yes表示注册成功了
            [[StorageMgr singletonStorageMgr] addKey:@"SignUpSuccessfully" andValue:@YES];
            //在单例化全局变量中保存用户名和密码以供登录页面自动登录使用
            [[StorageMgr singletonStorageMgr] addKey:@"Username" andValue:username];
            [[StorageMgr singletonStorageMgr] addKey:@"Password" andValue:password];
            //将密码文本输入框中的内容清掉
            _passwordTF.text = @"";
            _emailTF.text = @"";
            _passwordTF.text = @"";
            _confidPW.text = @"";
            _nicknameTF.text = @"";
            //回到登录页面
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            switch (error.code) {
                case 202:
                    [Utilities popUpAlertViewWithMsg:@"该用户名已被使用" andTitle:nil onView:self];
                    break;
                case 203:
                    [Utilities popUpAlertViewWithMsg:@"该电子邮箱已被使用" andTitle:nil onView:self];
                    break;
                case 100:
                    [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍候再试" andTitle:nil onView:self];
                    break;
                case 125:
                    [Utilities popUpAlertViewWithMsg:@"该电子邮箱地址不存在" andTitle:nil onView:self];
                    break;
                case 101:
                    [Utilities popUpAlertViewWithMsg:@"该昵称已被使用" andTitle:nil onView:self];
                default:
                    [Utilities popUpAlertViewWithMsg:@"服务器正在维护，请稍候再试" andTitle:nil onView:self];
                    break;
            }
        }
    }];

}
//当键盘按了右下角后会收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//按任何地方收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end

//
//  ViewController.m
//  NetFish
//
//  Created by tieruni on 16/4/16.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "LeftViewController.h"
@interface ViewController ()
@property (strong,nonatomic)ECSlidingViewController *slidingVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化一个bool格式的单例化全局变量来表示是否成功执行了注册操作，默认为否
    //加@转换为number对象
   [[StorageMgr singletonStorageMgr] addKey:@"SignUpSuccessfully" andValue:@NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //判断是否记忆了用户名
    if (![[Utilities getUserDefaults:@"Username"]isKindOfClass:[NSNull class]]) {
        //如果有记忆就把记忆显示在用户名文本输入框中
        _usernameTF.text = [Utilities getUserDefaults:@"Username"];
    }
}


 //每一次这个页面出现的时候都会调用这个方法，并且时机点是页面已经出现以后
 - (void)viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
 //判断是否是从注册页面注册成功后回到的这个登录页面
     if ([[[StorageMgr singletonStorageMgr]objectForKey:@"SignUpSuccessfully"]boolValue]) {
 //在自动登录前，将flag恢复为默认的NO
 [[StorageMgr singletonStorageMgr] removeObjectForKey:@"SignUpSuccessfully"];
 [[StorageMgr singletonStorageMgr] addKey:@"SignUpSuccessfully" andValue:@NO];
 //从单例化全局变量中提取用户名和密码
 NSString *username =[[StorageMgr singletonStorageMgr]objectForKey:@"Username"];
 NSString *password =[[StorageMgr singletonStorageMgr]objectForKey:@"Password"];
 //清除用完的用户名和密码
 [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Username"];
 [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Password"];
 //执行登录
 [self signInWithUsername:username andPassword:password];
 }
 }
-(void)muenuSwitchAction {
    NSLog(@"菜单");
    if (_slidingVC.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        //上述条件表示中间那扇门正移在右侧，说明门是打开的 因此我们需要将它关闭，也就是将中间的门移回中间
        [_slidingVC resetTopViewAnimated:YES];
    }else{
        //  反之
        [_slidingVC anchorTopViewToRightAnimated:YES];
    }
}
//激活移门手势
-(void)enableGestureAction {
    _slidingVC.panGesture.enabled = YES;
}
//关闭移门手势
-(void)disableGestureAction {
    _slidingVC.panGesture.enabled = NO;
}


//登录成功后执行的方法
-(void)popUpHome {
    
     //根据故事版的名称和故事版中页面的名称获得这个页面
   UINavigationController *homeVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Home"];
//    //初始化移门的门框,并且同时设置移门中间那扇门
//    _slidingVC = [ECSlidingViewController slidingWithTopViewController:homeVC];
//    //设置开门关门的耗时
//    _slidingVC.defaultTransitionDuration = 0.25f;
//    //设置控制移民开关的手势(这里同时对触摸和拖拽响应)
//    _slidingVC.topViewAnchoredGesture =ECSlidingViewControllerAnchoredGestureTapping |ECSlidingViewControllerAnchoredGesturePanning;
//    //设置手势的识别范围
//    [homeVC.view addGestureRecognizer:_slidingVC.panGesture];
//    
//    //根据故事版中页面的名字获得左滑页面的实例
//    LeftViewController *leftVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"left"];
//    
//    //设置移民靠左的那扇门
//    _slidingVC.underLeftViewController = leftVC;
//    //设置移门的开闭程度(设置左侧页面当被显示时，宽度能够显示屏幕宽度减去屏幕宽度1/4的宽度值)
//    _slidingVC.anchorRightPeekAmount = UI_SCREEN_W / 4;
//    //创建一个当菜单按钮被按时要执行的侧滑方法的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muenuSwitchAction) name:@"MenuSwitch" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableGestureAction) name:@"EnableGesture" object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableGestureAction) name:@"DisableGesture" object:nil];
    
    //modal方式跳转到上述页面
    [self presentViewController:homeVC animated:YES completion:nil];
    
    
}

////封装登录操作
-(void)signInWithUsername:(NSString *)username andPassword:(NSString *)password{
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //开始登录
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        //登录后的回调
        [avi stopAnimating];
        //判断是否登录成功
        if (user) {
            NSLog(@"登录成功");
            //记忆用户名
            [Utilities setUserDefaults:@"Username" content:username];
            //将密码文本输入框中的内容清掉
            _passwordTF.text = @"";
            //跳转到首页
            [self popUpHome];
        }else{
            switch (error.code) {
                case 101:
                    [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil onView:self];
                    break;
                case 100:
                    [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍候再试" andTitle:nil onView:self];
                    break;
                default:
                    [Utilities popUpAlertViewWithMsg:@"服务器正在维护，请稍候再试" andTitle:nil onView:self];
                    break;
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignInAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *password = _passwordTF.text;
    //判断用户是否输入信息
    if (username.length == 0 || password.length == 0 ) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil onView:self];
        return;
    }
    //执行登录
    [self signInWithUsername:username andPassword:password];
}

- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
}



- (IBAction)forgetPWAction:(UIButton *)sender forEvent:(UIEvent *)event {
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

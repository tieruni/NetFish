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
#import "XMNAnimTextFiled.h"


@interface ViewController ()<UIViewControllerAnimatedTransitioning,ECSlidingViewControllerDelegate,ECSlidingViewControllerLayout>

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong)   XMNAnimTextFiled *usernameTF1;
@property (nonatomic, strong)   XMNAnimTextFiled *passwordTF1;
@property (strong,nonatomic)ECSlidingViewController *slidingVC;
@property (assign, nonatomic) ECSlidingViewControllerOperation operation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _usernameTF1 = [[XMNAnimTextFiled alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 70)];
    [_usernameTF1 setPlaceHolderText:@"请输入用户名"];
    [self.view addSubview:_usernameTF1];
    
    
    _passwordTF1 = [[XMNAnimTextFiled alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 70)];
    [_passwordTF1 setTipsIcon:[UIImage imageNamed:@"invisible_icon"]];
    [_passwordTF1 setPlaceHolderIcon:[UIImage imageNamed:@"1"]];
    [_passwordTF1 setPlaceHolderText:@"请输入密码"];
    [_passwordTF1 setInputType:XMNAnimTextFieldInputTypePassword];
    [self.view addSubview:_passwordTF1];
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
        _usernameTF1.text = [Utilities getUserDefaults:@"Username"];
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
    //初始化移门的门框,并且同时设置移门中间那扇门
    _slidingVC = [ECSlidingViewController slidingWithTopViewController:homeVC];
    _slidingVC.delegate = self;
    //设置开门关门的耗时
    //_slidingVC.defaultTransitionDuration = 0.25f;
    //设置控制移民开关的手势(这里同时对触摸和拖拽响应)
    _slidingVC.topViewAnchoredGesture =ECSlidingViewControllerAnchoredGestureTapping |ECSlidingViewControllerAnchoredGesturePanning;
    //设置手势的识别范围
    [homeVC.view addGestureRecognizer:_slidingVC.panGesture];
    
    //根据故事版中页面的名字获得左滑页面的实例
    LeftViewController *leftVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"left"];
    
    //设置移民靠左的那扇门
    _slidingVC.underLeftViewController = leftVC;
    //设置移门的开闭程度(设置左侧页面当被显示时，宽度能够显示屏幕宽度减去屏幕宽度1/4的宽度值)
    _slidingVC.anchorRightPeekAmount = UI_SCREEN_W / 4;
    //创建一个当菜单按钮被按时要执行的侧滑方法的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muenuSwitchAction) name:@"MenuSwitch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableGestureAction) name:@"EnableGesture" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableGestureAction) name:@"DisableGesture" object:nil];
    
    //modal方式跳转到上述页面
    [self presentViewController:_slidingVC animated:YES completion:nil];
    
    
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
            _passwordTF1.text = @"";
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
    //POPSpringAnimation是专门制作有弹簧效果的制作器
    POPSpringAnimation *springForwardAnimation = [POPSpringAnimation animation];
    springForwardAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    springForwardAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.2, 1.2)];
    //设置弹簧的振幅（弹簧来回振动的位移量的大小）
    springForwardAnimation.springBounciness =10;
    //设置弹簧的弹性系数（弹簧来回振动的速度的快慢）
    springForwardAnimation.springSpeed =10;
    
    [_singIn pop_addAnimation:springForwardAnimation forKey:@"springForwardAnimation"];
    
    //设置动画完成以后的回调
    springForwardAnimation.completionBlock = ^(POPAnimation *anim,BOOL finished){
        POPBasicAnimation *basicBackwardAnimation = [POPBasicAnimation animation];
        basicBackwardAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
        basicBackwardAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0,1.0)];
        
        [_singIn pop_addAnimation:basicBackwardAnimation forKey:@"basicBackwardAnimation"];
    };
    
    
    //-----------------------------------
    NSString *username = _usernameTF1.text;
    NSString *password = _passwordTF1.text;
    //判断用户是否输入信息
    if (username.length == 0 || password.length == 0 ) {
        [Utilities popUpAlertViewWithMsg:@"请填写所有信息" andTitle:nil onView:self];
        return;
    }
    //执行登录
    [self signInWithUsername:username andPassword:password];
}

- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark - ECSlidingViewControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)slidingViewController:(ECSlidingViewController *)slidingViewController animationControllerForOperation:(ECSlidingViewControllerOperation)operation topViewController:(UIViewController *)topViewController {
    _operation = operation;
    return self;
}

- (id<ECSlidingViewControllerLayout>)slidingViewController:(ECSlidingViewController *)slidingViewController layoutControllerForTopViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition {
    return self;
}

#pragma mark - ECSlidingViewControllerLayout

- (CGRect)slidingViewController:(ECSlidingViewController *)slidingViewController frameForViewController:(UIViewController *)viewController topViewPosition:(ECSlidingViewControllerTopViewPosition)topViewPosition {
    if (topViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight && viewController == slidingViewController.topViewController) {
        return [self topViewAnchoredRightFrame:slidingViewController];
    } else {
        return CGRectInfinite;
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *topViewController = [transitionContext viewControllerForKey:ECTransitionContextTopViewControllerKey];
    UIViewController *underLeftViewController  = [transitionContext viewControllerForKey:ECTransitionContextUnderLeftControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *topView = topViewController.view;
    topView.frame = containerView.bounds;
    underLeftViewController.view.layer.transform = CATransform3DIdentity;
    
    if (_operation == ECSlidingViewControllerOperationAnchorRight) {
        [containerView insertSubview:underLeftViewController.view belowSubview:topView];
        
        [self topViewStartingStateLeft:topView containerFrame:containerView.bounds];
        [self underLeftViewStartingState:underLeftViewController.view containerFrame:containerView.bounds];
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftViewEndState:underLeftViewController.view];
            [self topViewAnchorRightEndState:topView anchoredFrame:[transitionContext finalFrameForViewController:topViewController]];
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                underLeftViewController.view.frame = [transitionContext finalFrameForViewController:underLeftViewController];
                underLeftViewController.view.alpha = 1;
                [self topViewStartingStateLeft:topView containerFrame:containerView.bounds];
            }
            [transitionContext completeTransition:finished];
        }];
    } else if (_operation == ECSlidingViewControllerOperationResetFromRight) {
        [self topViewAnchorRightEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
        [self underLeftViewEndState:underLeftViewController.view];
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            [self underLeftViewStartingState:underLeftViewController.view containerFrame:containerView.bounds];
            [self topViewStartingStateLeft:topView containerFrame:containerView.bounds];
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [self underLeftViewEndState:underLeftViewController.view];
                [self topViewAnchorRightEndState:topView anchoredFrame:[transitionContext initialFrameForViewController:topViewController]];
            } else {
                underLeftViewController.view.alpha = 1;
                underLeftViewController.view.layer.transform = CATransform3DIdentity;
                [underLeftViewController.view removeFromSuperview];
            }
            [transitionContext completeTransition:finished];
        }];
    }
}

#pragma mark - Private

- (CGRect)topViewAnchoredRightFrame:(ECSlidingViewController *)slidingViewController {
    CGRect frame = slidingViewController.view.bounds;
    
    frame.origin.x = slidingViewController.anchorRightRevealAmount;
    frame.size.width = frame.size.width * 0.75;
    frame.size.height = frame.size.height * 0.75;
    frame.origin.y = (slidingViewController.view.bounds.size.height - frame.size.height) / 2;
    
    return frame;
}

- (void)topViewStartingStateLeft:(UIView *)topView containerFrame:(CGRect)containerFrame {
    topView.layer.transform = CATransform3DIdentity;
    topView.layer.position = CGPointMake(containerFrame.size.width / 2, containerFrame.size.height / 2);
}

- (void)underLeftViewStartingState:(UIView *)underLeftView containerFrame:(CGRect)containerFrame {
    underLeftView.alpha = 0;
    underLeftView.frame = containerFrame;
    underLeftView.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1);
}

- (void)underLeftViewEndState:(UIView *)underLeftView {
    underLeftView.alpha = 1;
    underLeftView.layer.transform = CATransform3DIdentity;
}

- (void)topViewAnchorRightEndState:(UIView *)topView anchoredFrame:(CGRect)anchoredFrame {
    topView.layer.transform = CATransform3DMakeScale(0.75, 0.75, 1);
    topView.frame = anchoredFrame;
    topView.layer.position  = CGPointMake(anchoredFrame.origin.x + ((topView.layer.bounds.size.width * 0.75) / 2), topView.layer.position.y);
}




@end

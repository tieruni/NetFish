//
//  MineViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "MineViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CityViewController.h"
@interface MineViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate> {
    BOOL picked;
}

@property (strong,nonatomic) UIImagePickerController *imagePC;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _cityTF.text = [Utilities getUserDefaults:@"city"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cityTF.delegate = self;
    // Do any additional setup after loading the view.
    _imageview.userInteractionEnabled = YES;
    picked = NO;
    [self uiConfiguration];
    [self reloadInputViews];
    
}
-(void)uiConfiguration{

    PFUser *currentuser = [PFUser currentUser];
    PFFile *photo = currentuser[@"avatar"];
    NSString *photoURLStr = photo.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //异步加载和缓存
    [_imageview sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image5"]];
    
    NSString *nick =currentuser[@"nickname"];
    _usernameTF.text = nick;
    NSString *email = currentuser[@"email"];
    _emailLbl.text = email;
    NSString *city = currentuser[@"city"];
    _cityTF.text = city;
    NSString *gender = currentuser[@"gender"];
    NSLog(@"gender = %@",gender);
    if ([gender  isEqual: @"男"]) {
        _sex.selectedSegmentIndex = 0;
        
        
    }else{
        _sex.selectedSegmentIndex = 1;
//
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pickImage:(UIImagePickerControllerSourceType )sourceType{
    NSLog(@"照片被按了");
    //判断当前选择的图片选择器控制器类型是否可用
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        //神奇的nil
        _imagePC =nil;
        //初始化一个图片选择器对象
        _imagePC = [[UIImagePickerController alloc]init];
        //签协议
        _imagePC.delegate = self;
        //设置图片选择器控制器类型
        _imagePC.sourceType = sourceType;
        //设置选中的媒体文件是否可以被编辑
        _imagePC.allowsEditing = YES;
        //设置可以被选择的媒体文件的类型
        _imagePC.mediaTypes =@[(NSString *)kUTTypeImage];
        [self presentViewController:_imagePC animated:YES completion:nil];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:sourceType ==UIImagePickerControllerSourceTypeCamera ? @"您当前的设备没有照相功能" : @"meixiangce"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertView addAction:confirmAction];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    
}

- (IBAction)pickimage:(UITapGestureRecognizer *)sender {
    NSLog(@"asdadsasd");
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"照相" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickImage:UIImagePickerControllerSourceTypeCamera];
        
    }];
    UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickImage:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:takePhoto];
    [actionSheet addAction:choosePhoto];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}



//当选择完媒体文件后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //根据这个键去拿到我们选中的已经编辑过的图片
    UIImage *image= info[UIImagePickerControllerEditedImage];
    if (image) {
        picked = YES;
        //将拿到的图片设置为图片视图的图片
        _imageview.image = image;
    }
    //用model方式返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




/*
#pragma mark - Navigation
/Users/weilanhaiyu/Desktop/NetFish副本 2/NetFish副本
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sexAction:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
    
    PFUser *currentUser = [PFUser currentUser];
    if (_sex.selectedSegmentIndex == 0) {
        NSLog(@"男");
        currentUser[@"gender"] = @"男";

    }else{
        NSLog(@"女");
        currentUser[@"gender"] = @"女";
        
    }
    
}

- (IBAction)confirmAction:(UIButton *)sender forEvent:(UIEvent *)event {
    UIImage *image = _imageview.image;
    NSString *name = _usernameTF.text;
    NSString *city = _cityTF.text;
    
    if (name.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入昵称" andTitle:nil onView:self];
    } else {
        PFUser *currentUser = [PFUser currentUser];
        currentUser[@"nickname"] = name;
        //currentUser[@"gender"] = gender;
//        if (_sex.selectedSegmentIndex == 0) {
//            currentUser[@"gender"] = @"0";
//        }else {
//            currentUser[@"gender"] = @"1";
//        }
        currentUser[@"city"] = city;
        if (picked) {
            //将一个UIImage对象转换成png格式的数据流
            NSData *photoData = UIImagePNGRepresentation(image);
            PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
            currentUser[@"avatar"] = photoFile;
        }
        
        
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [aiv stopAnimating];
            if (succeeded) {
                [Utilities popUpAlertViewWithMsg:@"保存成功" andTitle:nil onView:self];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [Utilities popUpAlertViewWithMsg:@"网络繁忙，请稍后再试" andTitle:nil onView:self];
            }
        }];
    }
    POPSpringAnimation *springForwardAnimation = [POPSpringAnimation animation];
    springForwardAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    springForwardAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.2, 1.2)];
    //设置弹簧的振幅（弹簧来回振动的位移量的大小）
    springForwardAnimation.springBounciness =10;
    //设置弹簧的弹性系数（弹簧来回振动的速度的快慢）
    springForwardAnimation.springSpeed =10;
    
    [_confirmBtn pop_addAnimation:springForwardAnimation forKey:@"springForwardAnimation"];
    
    //设置动画完成以后的回调
    springForwardAnimation.completionBlock = ^(POPAnimation *anim,BOOL finished){
        POPBasicAnimation *basicBackwardAnimation = [POPBasicAnimation animation];
        basicBackwardAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
        basicBackwardAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0,1.0)];
        
        [_confirmBtn pop_addAnimation:basicBackwardAnimation forKey:@"basicBackwardAnimation"];
    };
    

    

    
    


}
//让Text View控件实现：当键盘return按钮被按下后收起键盘
//当文本输入视图中文字发生变化时调用（返回YES表示同意这个变化，返回NO币哦啊时不同意）
-(BOOL)textView:(UITableView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    //捕捉到return按钮被按下这一事件（return键按钮被按下实际上在文本输入视图中执行换行：／n）
    if ([text isEqualToString:@"/n"]) {
        //重设键盘初始响应器
        [textView resignFirstResponder];
    }
    return YES;
}
//键盘以外收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CityViewController *CityVc = [Utilities getStoryboardInstance:@"Main" byIdentity:@"CityVc"];
    [self presentViewController:CityVc animated:YES completion:nil];
    
}

@end

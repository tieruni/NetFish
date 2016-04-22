//
//  LeftViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/4/17.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "LeftViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
@interface LeftViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic) UIImagePickerController *imagePC;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当选择完媒体文件后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //根据UIImagePickerControllerEditedImage这个键拿到我们选中的已经编辑过的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //将上面拿到的图片设置为按钮的背景图片
    [_imageButton setBackgroundImage:image forState:UIControlStateNormal];
    //用model的方式返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//当取消选择后调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //用model的方式返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)pickImage:(UIImagePickerControllerSourceType)sourceType{
    NSLog(@"按钮被按了");
    //判断当前的图片选择器控制器类型是否可用
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        _imagePC = nil;
        //初始化一个图片控制器对象
        _imagePC = [[UIImagePickerController alloc]init];
        //签协议
        _imagePC.delegate = self;
        //设置图片选择器控制器类型
        _imagePC.sourceType = sourceType;
        //设置选中的媒体文件是否可以被编辑
        _imagePC.allowsEditing = YES;
        //设置可以被选择的媒体文件的类型
        _imagePC.mediaTypes = @[(NSString *)kUTTypeImage];
        [self presentViewController:_imagePC animated:YES completion:nil];
        
    }else {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:sourceType ==  UIImagePickerControllerSourceTypeCamera ? @"您当前的设备没有照相功能" :@"您当前的设备无法打开相册"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleCancel handler:nil];
        [alertView addAction:confirmAction];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)imageAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *currentUser = [PFUser currentUser];
    //    _usernameLbl.text = currentUser.username;
    NSLog(@"currentUser = %@", currentUser);
    if (currentUser) {
        NSLog(@"可以开始选取头像了");
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickImage:UIImagePickerControllerSourceTypeCamera];
            
            
        }];
        UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickImage:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        
        
        [actionSheet addAction:takePhoto];
        [actionSheet addAction:choosePhoto];
        [actionSheet addAction:cancelAction];
        [self presentViewController:actionSheet animated:YES completion:nil];
        
        
    }else{
        NSLog(@"当前用户没登录");
        
        
    }

}
- (IBAction)collectionAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [PFUser logOutInBackgroundWithBlock:^(NSError * error) {
        if (!error) {
            //
            UINavigationController *SignVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Sign"];
            [self presentViewController:SignVC animated:YES completion:nil];
            
        }else{
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接通畅" andTitle:nil onView:self];
        }
        //
        
        
        
    }];
    

}
@end

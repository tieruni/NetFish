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

@interface MineViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic) UIImagePickerController *imagePC;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageview.userInteractionEnabled = YES;
    
    
    
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
    //将拿到的图片设置为图片视图的图片
    _imageview.image = image;
    //用model方式返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirmAction:(UIButton *)sender forEvent:(UIEvent *)event {
    UIImage *image = _imageview.image;
    NSString *name = _usernameTF.text;
    NSString *sex = _sexTF.text;
    NSString *city = _cityTF.text;
    //NSString *email = _emailLbl.text;
    PFObject *user = [PFObject objectWithClassName:@"User"];
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"nickname"] = name;
    currentUser[@"gender"] = sex;
    currentUser[@"city"] = city;
    //将一个UIImage对象转换成png格式的数据流
    NSData *photoData = UIImagePNGRepresentation(image);
    PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
    user[@"avatar"] = photoFile;
//   if (name != currentUser[@"nickname"] &&city !=currentUser[@"city"] && sex !=currentUser[@"gender"]) {
//        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
//        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            
//            [aiv stopAnimating];
//            if (succeeded) {
//                
//                //只有当2个数据库操作都完成以后才应该让菊花停转
//                [aiv stopAnimating];
//                [Utilities popUpAlertViewWithMsg:@"保存成功" andTitle:nil onView:self];
//                
//            }else{
//                
//                
//                [Utilities popUpAlertViewWithMsg:@"系统繁忙，请稍后再试" andTitle:nil onView:self];
//            }
//        }];
//    }else{
//        if (name.length ==0) {
//            [Utilities popUpAlertViewWithMsg:@"请输入昵称" andTitle:nil onView:self];
//        }
//        [Utilities popUpAlertViewWithMsg:@"您当前没有做任何修改" andTitle:nil onView:self];
//    }
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error){
        if (succeeded) {
            [aiv stopAnimating];
            //[Utilities popUpAlertViewWithMsg:@"保存成功" andTitle:nil onView:self];
            if(name !=currentUser[@"nickname"]||city!=currentUser[@"city"]|| sex !=currentUser[@"gender"]){
                [Utilities popUpAlertViewWithMsg:@"保存成功" andTitle:nil onView:self];
                
                
                
            }else{
                [Utilities popUpAlertViewWithMsg:@"您还未做修改" andTitle:nil onView:self];
            }
            
        }else{
            [Utilities popUpAlertViewWithMsg:@"系统繁忙，请稍后再试" andTitle:nil onView:self];
            
        }
        
        
        
        
    }];
    
    
}





@end

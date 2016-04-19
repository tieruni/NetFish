//
//  KSGuideManager.h
//  测试2
//
//  Created by fanfan on 16/4/18.
//  Copyright © 2016年 fanfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KSGuideManager : NSObject
+ (instancetype)shared;

-(void)showGuideViewWithImages:(NSArray *)images;
@end

//
//  WJAdvertCircle.h
//  WJAdvertCircle
//
//  Created by wj on 16/2/29.
//  Copyright © 2016年 wj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJAdvertClickDelegate <NSObject>

- (void)clickWithUrl:(NSString *)url;

@end

@interface WJAdvertCircle : UIView


@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,weak) id<WJAdvertClickDelegate>delegate;



/**
 * 显示广告轮播
 */
-(void)showImages:(NSArray *)imageArray urls:(NSArray *)urlArray isRepeat:(BOOL)isRepeat isTiming:(BOOL)isTiming;

/**
 * 移除广告轮播
 */
- (void)removeAdvert;




@end

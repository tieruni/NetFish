//
//  WJAdvertCircle.m
//  WJAdvertCircle
//
//  Created by wj on 16/2/29.
//  Copyright © 2016年 wj. All rights reserved.
//

#import "WJAdvertCircle.h"

@interface WJAdvertCircle ()<UIScrollViewDelegate>

{
    UIScrollView *_src;
    NSArray *_imageArray;
    NSArray *_urlArray;
    NSInteger _currentPage;
    NSUInteger _count;
    BOOL _isRepeat;
    BOOL _isTiming;
    NSTimer *_timer;
    
}


@end

@implementation WJAdvertCircle


-(void)showImages:(NSArray *)imageArray urls:(NSArray *)urlArray isRepeat:(BOOL)isRepeat isTiming:(BOOL)isTiming {
    _imageArray = [NSArray arrayWithArray:imageArray];
    _urlArray = [NSArray arrayWithArray:urlArray];
    _isRepeat = isRepeat;
    _isTiming = isTiming;

    [self reloadData];
}

- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = [NSArray arrayWithArray:imageArray];
    
}


//重写父类方法
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //定制view
        [self customView];
        
    }
    return self;
}
-(void)customView{
  
    //创建ScrollView
    _src= [[UIScrollView alloc]initWithFrame:self.bounds];
    _src.pagingEnabled = YES;
    _src.showsHorizontalScrollIndicator = NO;
    _src.bounces = NO;
    _src.delegate = self;
    [self addSubview:_src];
    
}
//刷新数据
-(void)reloadData{

    

    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(150, self.frame.size.height-30, 100, 30)];
    
    
    if (_isRepeat) {
        
        NSUInteger number = _imageArray.count;
        NSMutableArray *repeatArray = [NSMutableArray arrayWithArray:_imageArray];
        NSMutableArray *repeatUrlArray = [NSMutableArray arrayWithArray:_urlArray];
        
        [repeatArray insertObject:_imageArray[number-1] atIndex:0];
        [repeatUrlArray insertObject:_urlArray[number-1] atIndex:0];
        
        [repeatArray addObject:_imageArray[0]];
        [repeatUrlArray addObject:_urlArray[0]];
        
        
        _count = repeatArray.count;
        
        for (int i = 0; i < _count; i++) {
            UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [imageView setBackgroundImage:[UIImage imageNamed:repeatArray[i]] forState:UIControlStateNormal];
            [imageView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [imageView setTitle:repeatUrlArray[i] forState:UIControlStateNormal];
            [imageView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [_src addSubview:imageView];

        }

        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = repeatArray.count - 2;
        _currentPage = 1;
        _src.contentSize = CGSizeMake(repeatArray.count*self.frame.size.width, self.frame.size.height);
        _src.contentOffset = CGPointMake(self.frame.size.width,0);
    }else{
     
        for (int i = 0; i < _imageArray.count; i++) {
            UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [imageView setBackgroundImage:[UIImage imageNamed:_imageArray[i]] forState:UIControlStateNormal];
            [imageView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [imageView setTitle:_urlArray[i] forState:UIControlStateNormal];
            [imageView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_src addSubview:imageView];
       
            
        }
        _pageControl.numberOfPages = _imageArray.count;
        _src.contentSize = CGSizeMake(_imageArray.count*self.frame.size.width, self.frame.size.height);
    }
    
    [self addSubview:_pageControl];
    
    if (_isTiming && _isRepeat) {
       _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(repeatCircle) userInfo:nil repeats:YES];
    }
    
}

- (void)click:(UIButton *)button{
 
    if ([_delegate respondsToSelector:@selector(clickWithUrl:)] && _delegate) {
        [_delegate clickWithUrl:button.titleLabel.text];
    }
    
}

- (void)repeatCircle{

    CGPoint point = CGPointMake(_src.contentOffset.x + self.frame.size.width, 0);

    [UIView animateWithDuration:0.7 animations:^{
        _src.contentOffset = CGPointMake(point.x, point.y);
    }];
    
    [self contentOffsetAndPage];
    
}

- (void)contentOffsetAndPage{
    
    CGPoint point = _src.contentOffset;
    
    if (_isRepeat) {
        
        if (point.x == 0) {
            _src.contentOffset = CGPointMake(self.frame.size.width * (_count - 2), 0);
        }
        if (point.x == self.frame.size.width * (_count - 1)) {
            _src.contentOffset = CGPointMake(self.frame.size.width, 0);
        }

        _currentPage = _src.contentOffset.x/self.frame.size.width;
        _pageControl.currentPage = _currentPage-1;
        
        
    }else{
        
        _pageControl.currentPage = point.x/self.frame.size.width;
    }

    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
 
    [_timer invalidate];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self contentOffsetAndPage];
    
    if (_isTiming && _isRepeat) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(repeatCircle) userInfo:nil repeats:YES];
    }

    
}
- (void)removeAdvert{
    
    _timer = nil;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
    
}

- (void)dealloc{
    _timer = nil;
    NSLog(@"dealloc");
}


@end

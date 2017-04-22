//
//  LCScrollView.h
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCScrollView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIImageView*imageView;
@property(nonatomic,strong)UIPageControl*page;


@end

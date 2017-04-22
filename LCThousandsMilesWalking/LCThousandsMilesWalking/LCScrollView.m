//
//  LCScrollView.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCScrollView.h"

@implementation LCScrollView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    _scrollView=[[UIScrollView alloc] initWithFrame:rect];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate=self;
    _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width*3, 0);
    for (int i=0; i<3; i++) {
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width*i, 0, rect.size.width, rect.size.height)];
        [_imageView setImage:[UIImage imageNamed:@"firsticon.png"]];
        [_scrollView addSubview:_imageView];
    }
    [self addSubview:_scrollView];
    _page=[[UIPageControl alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width/2-25, _scrollView.frame.size.height-20,50, 20)];
    _page.numberOfPages =  3;
    _page.currentPage = 0;
    [_page addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_page];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 3) / pageWidth) + 1;
    _page.currentPage = page;
   
}

- (void)pageTurn:(UIPageControl*)sender
{
    CGSize viewSize = _scrollView.frame.size;
    CGPoint point;
    point.x = sender.currentPage*viewSize.width;
    _scrollView.contentOffset = point;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  RMCQFloatingToolBar.h
//  FloatingToolbar
//
//  Created by LiuChao on 13-10-12.
//  Copyright (c) 2013年 LiuChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMCQFloatingToolBarDefine.h"
/** 抽屉视图 委托协议 */
@protocol RMCQFloatingToolBarDelegate <NSObject>

@required
/** 关闭按钮 代理回调方法 */
-(void)theBtnPressed:(RMCQFLOATINGTOOLBAR_FNUCTION_TYPE )type addButton:(UIButton*)button;

@optional
/** 触摸背景 遮罩 代理回调方法 */
-(void)theBGMaskTapped;

@end

@interface RMCQFloatingToolBar : UIView
{
    float floatingToolBarWidth;
    float floatingToolBarHeight;
    float parentViewWith;
    float parentViewHeighe;
    UIButton* soundbutton;
    UIButton* stopbutton;
    UIButton* ptzbutton;
    UIButton* recordbutton;
}
@property(assign,nonatomic)float floatingToolBarWidth;
@property(assign,nonatomic)float floatingToolBarHeight;
@property(assign,nonatomic)float parentViewWith;
@property(assign,nonatomic)float parentViewHeighe;
@property (nonatomic, assign) id <RMCQFloatingToolBarDelegate> delegate;

@property(nonatomic,retain)UIButton* soundbutton;
@property(nonatomic,retain)UIButton* stopbutton;
@property(nonatomic,retain)UIButton* ptzbutton;
@property(nonatomic,retain)UIButton* recordbutton;

-(id)initWithView:(UIView*)theView andFrame:(CGRect)theFrame andItemInfoArray:(NSArray*)theArray andParentViewWith:(float)parentViewWith andParentViewHeight:(float)parentViewHeighe addType:(RMCQFLOATINGTOOLBAR_TYPE)type;
- (void)show;
- (void)dismiss;
@end
